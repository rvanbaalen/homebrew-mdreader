class Mdreader < Formula
  desc "A beautiful macOS markdown reader"
  homepage "https://github.com/rvanbaalen/mdreader"
  url "https://github.com/rvanbaalen/mdreader/releases/download/v1.0.3/mdreader-1.0.3-arm64-mac.zip"
  sha256 "311750cc2b6441bcfe31237182c3dc5a0799cd89b54e825560f700a38b625a8d"
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
