{myvars, ...}: {
  # sudo NOPASSWD
  security.sudo.extraRules = [
    {
      users = [myvars.username];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];
}
