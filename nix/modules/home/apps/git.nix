{ custom, ... }: {
  programs = {
    git = {
      enable = true;
      userName = "aloshy.🅰🅸";
      userEmail = "noreply@aloshy.ai";
      lfs = {
        enable = true;
      };
    };
  };
}
