{...}: {
  services.karabiner-elements = {
    enable = true;
    settings = {
      global = {
        check_for_updates_on_startup = true;
      };
    };
  };
}
