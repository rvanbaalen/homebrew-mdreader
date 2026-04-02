class Mdreader < Formula
  desc "A beautiful macOS markdown reader"
  homepage "https://github.com/rvanbaalen/mdreader"
  url "https://github.com/rvanbaalen/mdreader/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "2f7bfc35de45d31d1e6a73f3ce5536b3f1249986f5d3645ab470daef39465a53"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on :macos => :sonoma

  def install
    system "bash", "build.sh"
    prefix.install "mdreader.app"
    bin.install_symlink prefix/"mdreader.app/Contents/MacOS/mdreader"
  end

  def post_install
    # Register with LaunchServices so the OS knows about the app
    system "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister", "#{prefix}/mdreader.app"
  end

  def caveats
    <<~EOS
      To add mdreader to your Applications folder, run:
        ln -sf #{prefix}/mdreader.app /Applications/mdreader.app

      Usage:
        open -a mdreader README.md
        mdreader README.md
    EOS
  end

  test do
    assert_predicate prefix/"mdreader.app", :exist?
    assert_predicate prefix/"mdreader.app/Contents/MacOS/mdreader", :executable?
  end
end
