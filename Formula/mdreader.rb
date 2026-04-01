class Mdreader < Formula
  desc "A beautiful macOS markdown reader"
  homepage "https://github.com/rvanbaalen/mdreader"
  url "https://github.com/rvanbaalen/mdreader/archive/refs/tags/v2.0.0.tar.gz"
  sha256 :no_check
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on :macos => :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    app_bundle = prefix/"mdreader.app"
    (app_bundle/"Contents/MacOS").mkpath
    (app_bundle/"Contents/Resources").mkpath

    cp ".build/release/mdreader", app_bundle/"Contents/MacOS/mdreader"

    # Copy bundled resources
    if File.exist?(".build/release/mdreader_mdreader.bundle")
      cp_r ".build/release/mdreader_mdreader.bundle", app_bundle/"Contents/Resources/mdreader_mdreader.bundle"
    end

    # Copy icon
    if File.exist?("build/icon.icns")
      cp "build/icon.icns", app_bundle/"Contents/Resources/AppIcon.icns"
    end

    (app_bundle/"Contents/Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleName</key>
        <string>mdreader</string>
        <key>CFBundleDisplayName</key>
        <string>mdreader</string>
        <key>CFBundleIdentifier</key>
        <string>com.rvanbaalen.mdreader</string>
        <key>CFBundleVersion</key>
        <string>#{version}</string>
        <key>CFBundleShortVersionString</key>
        <string>#{version}</string>
        <key>CFBundleExecutable</key>
        <string>mdreader</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleIconFile</key>
        <string>AppIcon</string>
        <key>LSMinimumSystemVersion</key>
        <string>14.0</string>
        <key>CFBundleDocumentTypes</key>
        <array>
          <dict>
            <key>CFBundleTypeExtensions</key>
            <array>
              <string>md</string>
              <string>markdown</string>
            </array>
            <key>CFBundleTypeName</key>
            <string>Markdown Document</string>
            <key>CFBundleTypeRole</key>
            <string>Viewer</string>
            <key>LSHandlerRank</key>
            <string>Default</string>
          </dict>
        </array>
      </dict>
      </plist>
    PLIST

    system "codesign", "--force", "--sign", "-", "--deep", app_bundle.to_s

    bin.install_symlink app_bundle/"Contents/MacOS/mdreader"
  end

  def post_install
    system "ln", "-sf", "#{prefix}/mdreader.app", "/Applications/mdreader.app"
  end

  def caveats
    <<~EOS
      mdreader.app has been linked to /Applications.
      Open a file: open -a mdreader README.md
      Open a folder: open -a mdreader ./docs
    EOS
  end

  test do
    assert_predicate prefix/"mdreader.app", :exist?
  end
end
