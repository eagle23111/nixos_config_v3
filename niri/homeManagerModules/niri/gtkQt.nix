{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.gnome-themes-extra; # Or pkgs.materia-theme for "Materia-dark"
      name = "Adwaita-dark"; # Exact name from package's share/themes/
    };

    # Optional: icons and cursor
    iconTheme = {
      package = pkgs.everforest-gtk-theme;
      name = "orchis";
    };

    # Font example
    font = {
      name = "Fira Sans";
      size = 11;
    };
  };

  qt = {
    enable = true;

    # Platform theme integrates with DEs/environments
    platformTheme = {
      name = "gtk"; # Uses qtstyleplugins to follow GTK theme
      # Or "qtct" for qt5ct/qt6ct apps, "kvantum" for Kvantum
    };

    # Alternative: direct style override
    /*
      style = {
      name = "kvantum";  # Or "adwaita-dark", "breeze"
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
    */
  };
}
