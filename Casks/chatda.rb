cask "chatda" do
  version "9.33.0"
  sha256 "34b7bf918616828cc6eba513788c816a11e3e3fdc5ef51e2d7da35bcae21d24c"

  url "https://github.com/barbellsoft/chatda-releases/releases/download/v#{version}/Chatda_universal.dmg"
  name "Chatda"
  desc "Search files by name and by the text inside documents"
  homepage "https://barbellsoft.com/chatda/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on :macos

  app "Chatda.app"

  # Chatda is not signed or notarized by Apple yet, so macOS would refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "Chatda.app"],
        chdir:          ".",
        writable_paths: ["Chatda.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  zap trash: [
    "~/Library/Application Support/app.chatda",
    "~/Library/Caches/app.chatda",
    "~/Library/Preferences/app.chatda.plist",
    "~/Library/Saved Application State/app.chatda.savedState",
    "~/Library/WebKit/app.chatda",
  ]

  caveats <<~EOS
    Chatda is not yet signed or notarized by Apple. This cask removes the
    quarantine flag from Chatda.app so that it can open.
  EOS
end
