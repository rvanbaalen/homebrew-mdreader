cask "mdreader" do
  version "0.1.0"
  sha256 :no_check

  url "https://github.com/rvanbaalen/mdreader/releases/download/v#{version}/mdreader-#{version}-mac.zip"
  name "mdreader"
  desc "A beautiful macOS markdown reader"
  homepage "https://github.com/rvanbaalen/mdreader"

  app "mdreader.app"

  zap trash: [
    "~/Library/Application Support/mdreader",
    "~/Library/Preferences/com.rvanbaalen.mdreader.plist",
  ]
end
