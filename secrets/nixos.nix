{
  lib,
  config,
  pkgs,
  agenix,
  mysecrets,
  myvars,
  ...
}:
with lib; let
  cfg = config.modules.secrets;

  noaccess = {
    mode = "0000";
    owner = "root";
  };
  high_security = {
    mode = "0500";
    owner = "root";
  };
  user_readable = {
    mode = "0500";
    owner = myvars.username;
  };
in {
  imports = [
    agenix.nixosModules.default
  ];

  options.modules.secrets = {
    desktop.enable = mkEnableOption "NixOS Secrets for Desktops";

    server.application.enable = mkEnableOption "NixOS Secrets for Application Servers";

    impermanence.enable = mkEnableOption "Wether use impermanence and ephemeral root file system";
  };

  config =
    mkIf
    (
      cfg.desktop.enable
      || cfg.server.application.enable
    )
    (mkMerge [
      {
        environment.systemPackages = [
          agenix.packages."${pkgs.system}".default
        ];

        # if you changed this key, you need to regenerate all encrypt files from the decrypt contents!
        age.identityPaths =
          if cfg.impermanence.enable
          then [
            # To decrypt secrets on boot, this key should exists when the system is booting,
            # so we should use the real key file path(prefixed by `/persistent/`) here, instead of the path mounted by impermanence.
            "/persistent/etc/ssh/ssh_host_ed25519_key" # Linux
          ]
          else [
            "/etc/ssh/ssh_host_ed25519_key"
          ];

        assertions = [
          {
            # This expression should be true to pass the assertion
            assertion =
              !(cfg.desktop.enable
                && (
                  cfg.server.application.enable
                ));
            message = "Enable either desktop or server's secrets, not both!";
          }
        ];
      }

      (mkIf cfg.desktop.enable {
        age.secrets = {
          # ---------------------------------------------
          # no one can read/write this file, even root.
          # ---------------------------------------------

          # .age means the decrypted file is still encrypted by age(via a passphrase)
          # "ryan4yin-gpg-subkeys.priv.age" =
          #   {
          #     file = "${mysecrets}/ryan4yin-gpg-subkeys-2024-01-27.priv.age.age";
          #   }
          #   // noaccess;
        };

        # place secrets in /etc/
        # environment.etc = {
        #   "agenix/cloudflared" = {
        #     source = config.age.secrets."cloudflared-miemie.json".path;
        #   };
        # };
      })

      (mkIf cfg.server.application.enable {
        age.secrets = {
          # ---------------------------------------------
          # user can read this file.
          # ---------------------------------------------
          "wakatime.cfg" =
            {
              file = "${mysecrets}/wakatime.cfg.age";
            }
            // user_readable;

          # ---------------------------------------------
          # only cloudflared can read this file.
          # ---------------------------------------------
          # "cloudflared-miemie.json" = {
          #   file = "${mysecrets}/cloudflared/miemie.json.age";
          #   mode = "0500";
          #   owner = "cloudflared";
          # };
        };

        # place secrets in /etc/
        environment.etc = {
          "agenix/.wakatime.cfg" = {
            source = config.age.secrets."wakatime.cfg".path;
          };
        };
      })
    ]);
}
