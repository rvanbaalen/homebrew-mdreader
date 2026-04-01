cask "mdreader" do
  version "1.0.3"
  sha256 "dbe076283f53666fc35003daad0b6cf8cdccb92f94ce60ff7fc20db235824f89"

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
