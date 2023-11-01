{lib, ...}: {
  disko.devices = {
    disk = {
      vda = {
        device = lib.mkDefault "/dev/vda";
        type = "disk";
        content = {
          type = "msdos";
          partitions = {
            boot = {
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      # vdb = {
      #   device = "/dev/vdb";
      #   type = "disk";
      #   content = {
      #     type = "gpt";
      #     partitions = {
      #       store = {
      #         name = "store";
      #         size = "100%";
      #         content = {
      #           type = "filesystem";
      #           format = "ext4";
      #           mountpoint = "/vdb";
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };
}
