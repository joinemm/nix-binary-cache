{
  disko.devices = {
    disk = {
      vda = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "boot";
              start = "0";
              end = "1M";
              part-type = "primary";
              flags = ["bios_grub"];
            }
            {
              name = "ESP";
              start = "1MiB";
              end = "100MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            }
            {
              name = "root";
              start = "100MiB";
              end = "100%";
              part-type = "primary";
              bootable = true;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            }
          ];
        };
      };
      vdb = {
        device = "/dev/vdb";
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "store";
              start = "0";
              end = "100%";
              part-type = "primary";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/vdb";
              };
            }
          ];
        };
      };

    };
  };
}
