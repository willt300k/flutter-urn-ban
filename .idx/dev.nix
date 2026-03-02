{ pkgs, ... }: {
  channel = "stable-24.05";

  packages = [
    pkgs.jdk21
    pkgs.flutter
    pkgs.android-tools
    pkgs.git
  ];

  # Thiết lập môi trường để tận dụng tối đa 32GB RAM
env = {
  # Cho phép Flutter sử dụng nhiều nhân CPU hơn khi build
  FLUTTER_EXTRA_CONF = "--multithreaded";
  
  # Tăng giới hạn quan sát file của Linux (tránh lỗi treo khi project có nhiều asset game)
  FS_INOTIFY_MAX_USER_WATCHES = "524288";
  
  # Tối ưu Java cho môi trường 32GB RAM
  _JAVA_OPTIONS = "-Xmx8g -XX:+UseG1GC";
};

  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
      "tamasfe.even-better-toml"
    ];

    workspace = {
      # Tự động chạy khi mở Workspace để đảm bảo mọi thứ sẵn sàng
      onStart = {
        # Dọn dẹp build cũ để tránh lỗi xung đột gây ANR
        clean-folders = "rm -rf build";
        # Tải lại các thư viện
        pub-get = "flutter pub get";
      };
    };

    previews = {
      enable = true;
      previews = {
        android = {
          # Sử dụng kiến trúc máy ảo mặc định nhưng bỏ qua các bước kiểm tra dư thừa
          command = ["flutter" "run" "--machine" "-d" "android" "--no-pub" "--no-track-widget-creation"];
          manager = "flutter";
        };
      };
    };
  };
}
