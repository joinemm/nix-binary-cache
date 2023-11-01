{
  modulesPath,
  config,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
  ];

  system.stateVersion = "23.05";

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];
  boot.kernelModules = ["kvm_intel"];
  boot.initrd.kernelModules = [];
  boot.kernelParams = [
    "console=tty1"
    "console=ttyS0,115200"
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking = {
    hostName = "binarycache";
    nameservers = ["1.1.1.1" "8.8.8.8"];
  };

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "ter-v32n";
    packages = with pkgs; [terminus_font];
  };

  services = {
    nix-serve.enable = true;
    qemuGuest.enable = true;
  };

  users = {
    users = {
      "jrautiola" = {
        isNormalUser = true;
        extraGroups = ["wheel" "docker"];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdrlMsN+yqst4ThORcm9Jf2g5JNVWcjIkzkRow8BCChZjC/EqbVCAeN8LfdGniefre49KNc40IxJENnrtu3TitFHDBhuRYrFJ1csK6dD1pZBeFrCPrWjr7b1e9PwusQddI7Xi/amSf8XlmBvDMXRnvqFnBD4xNdmd5DMPDi2Q5FjzNqlsuEAPPegahb0OoGIYGbwUfHtVDtUtuN6oYUYuQbiz92Fjpy5tyz/Bb4Wrw7iphL5nITM0l/BdtGFv4D/UUa3cju74xIm5Qi93qBaNXhQwRVv1c2pzBQvwQltjQYxV9kvTcG24cI+iS/XUaalKV539q/wXaC9h5aKEYyMn+TzuATZsvcP45JQeZpkMcOsCCKroIvOzeizfYbIW7+T5rdhkC0PFfmo1/WYQ4fcbukgEBa3OjuG8LGZvHo7BLj46s+qW3dV+WemhIHiFXYI9sTaXzL4pxgXI1DwYaz1tSMOQTOh+rYqjhUaaqsQqLdbcdBlrpInIvZqpC3VUkTyU= join@cerberus"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII6EoeiMBiiwfGJfQYyuBKg8rDpswX0qh194DUQqUotL joonas@buutti"
        ];
        initialPassword = "asdf";
      };
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdrlMsN+yqst4ThORcm9Jf2g5JNVWcjIkzkRow8BCChZjC/EqbVCAeN8LfdGniefre49KNc40IxJENnrtu3TitFHDBhuRYrFJ1csK6dD1pZBeFrCPrWjr7b1e9PwusQddI7Xi/amSf8XlmBvDMXRnvqFnBD4xNdmd5DMPDi2Q5FjzNqlsuEAPPegahb0OoGIYGbwUfHtVDtUtuN6oYUYuQbiz92Fjpy5tyz/Bb4Wrw7iphL5nITM0l/BdtGFv4D/UUa3cju74xIm5Qi93qBaNXhQwRVv1c2pzBQvwQltjQYxV9kvTcG24cI+iS/XUaalKV539q/wXaC9h5aKEYyMn+TzuATZsvcP45JQeZpkMcOsCCKroIvOzeizfYbIW7+T5rdhkC0PFfmo1/WYQ4fcbukgEBa3OjuG8LGZvHo7BLj46s+qW3dV+WemhIHiFXYI9sTaXzL4pxgXI1DwYaz1tSMOQTOh+rYqjhUaaqsQqLdbcdBlrpInIvZqpC3VUkTyU= join@cerberus"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII6EoeiMBiiwfGJfQYyuBKg8rDpswX0qh194DUQqUotL joonas@buutti"
        ];
        initialPassword = "asdf";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    neovim
    wget
    git
  ];

  services.openssh.enable = true;
}
