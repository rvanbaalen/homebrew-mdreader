cask "mdreader" do
  version "1.0.3"
  sha256 "3302f1abcfac5016e35c13b8c1e9c6dfd334bbdb8f52eaa4b8c04bd69fb7a806"

  url "https://github.com/rvanbaalen/mdreader/releases/download/v#{version}/mdreader-#{version}-arm64-mac.zip"
  name "mdreader"
  desc "A beautiful macOS markdown reader"
  homepage "https://github.com/rvanbaalen/mdreader"

  app "mdreader.app"

  zap trash: [
    "~/Library/Application Support/mdreader",
    "~/Library/Preferences/com.rvanbaalen.mdreader.plist",
  ]
end
