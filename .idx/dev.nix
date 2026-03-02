{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = [
    pkgs.jdk21
    pkgs.flutter
    pkgs.android-tools
  ];

env = {
  # Cho phép Flutter sử dụng nhiều nhân CPU hơn khi build
  FLUTTER_EXTRA_CONF = "--multithreaded";
  
  # Tăng giới hạn quan sát file của Linux (tránh lỗi treo khi project có nhiều asset game)
  FS_INOTIFY_MAX_USER_WATCHES = "524288";
  
  # Tối ưu Java cho môi trường 32GB RAM
  _JAVA_OPTIONS = "-Xmx8g -XX:+UseG1GC";
};
  idx = {
    extensions = [ "Dart-Code.flutter" "Dart-Code.dart-code" ];
    previews = {
      enable = true;
      previews = {
        # Ưu tiên chạy Web để tránh tốn RAM cho Emulator Android
        web = {
          command = ["flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT"];
          manager = "flutter";
        };
        android = {
          # Thêm --no-pub và --filesystem-cache-flush để giảm tải ổ cứng/RAM
          command = ["flutter" "run" "--machine" "-d" "android" "--no-pub"];
          manager = "flutter";
        };
      };
    };
  };
}
