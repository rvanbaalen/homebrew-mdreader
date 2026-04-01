class Mdreader < Formula
  desc "A beautiful macOS markdown reader"
  homepage "https://github.com/rvanbaalen/mdreader"
  url "https://github.com/rvanbaalen/mdreader/releases/download/v1.0.3/mdreader-1.0.3-arm64-mac.zip"
  sha256 "dbe076283f53666fc35003daad0b6cf8cdccb92f94ce60ff7fc20db235824f89"
  license "MIT"

  def install
    prefix.install "mdreader.app"
  end

  def post_install
    system "ln", "-sf", "#{prefix}/mdreader.app", "/Applications/mdreader.app"
  end

  def caveats
    <<~EOS
      mdreader.app has been linked to /Applications.
      To open: open -a mdreader file.md
    EOS
  end

  test do
    assert_predicate prefix/"mdreader.app", :exist?
  end
end
