class Mdreader < Formula
  desc "A beautiful macOS markdown reader"
  homepage "https://github.com/rvanbaalen/mdreader"
  url "https://github.com/rvanbaalen/mdreader/archive/refs/tags/v2.0.0.tar.gz"
  sha256 :no_check
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on :macos => :sonoma

  def install
    # Use the project's build script which handles everything
    system "bash", "build.sh"

    # Move the assembled .app into the Cellar prefix
    prefix.install "mdreader.app"

    # Symlink the CLI binary
    bin.install_symlink prefix/"mdreader.app/Contents/MacOS/mdreader"
  end

  def post_install
    # Link .app to ~/Applications (doesn't need sudo, unlike /Applications)
    user_apps = File.expand_path("~/Applications")
    FileUtils.mkdir_p(user_apps)
    target = "#{user_apps}/mdreader.app"
    FileUtils.rm_f(target)
    FileUtils.ln_sf("#{prefix}/mdreader.app", target)
    ohai "mdreader.app linked to ~/Applications"

    # Register with LaunchServices
    system "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister", "#{prefix}/mdreader.app"
  end

  def caveats
    <<~EOS
      mdreader.app has been installed to ~/Applications.

      Open a file:   open -a mdreader README.md
      Open a folder: open -a mdreader ./docs
      Or just:       mdreader README.md
    EOS
  end

  test do
    assert_predicate prefix/"mdreader.app", :exist?
    assert_predicate prefix/"mdreader.app/Contents/MacOS/mdreader", :executable?
  end
end
