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
    # Cho phép Java sử dụng tới 8GB RAM cho việc build (tránh nghẽn cổ chai)
    _JAVA_OPTIONS = "-Xmx8g -XX:+UseG1GC -XX:+ParallelRefProcEnabled";
    
    # Ép Gradle chạy song song trên 8 nhân CPU
    FLUTTER_EXTRA_CONF = "--multithreaded";
    
    # Tối ưu hóa bộ nhớ đệm cho Flutter
    FLUTTER_ROOT = "${pkgs.flutter}";
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
