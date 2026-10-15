cask "agent-sounds-bar" do
  version "1.0.0"
  sha256 "40e0f8ec1dd030cfbafa4fe27b8c3536fd6866bbd59114fae403977b85461364"

  url "https://github.com/ealexisaraujo/agent-sounds-bar/releases/download/v#{version}/AgentSoundsBar-#{version}.zip"
  name "Agent Sounds Bar"
  desc "Menu bar control for the sounds coding agents play"
  homepage "https://github.com/ealexisaraujo/agent-sounds-bar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  # play-sound reads its settings with jq. macOS 15+ ships /usr/bin/jq; macOS 14 does not.
  depends_on formula: "jq"

  app "AgentSoundsBar.app"

  # No `uninstall quit:` on purpose: the app runs `brew upgrade` itself and relaunches afterwards,
  # so quitting it mid-upgrade would leave nothing to bring it back.

  zap trash: [
    "~/.config/agent-sounds",
    "~/Library/Preferences/com.alexisaraujo.AgentSoundsBar.plist",
  ]

  caveats <<~EOS
    Open Agent Sounds Bar from Applications. The setup guide installs the play-sound
    command and connects Claude Code and Codex, showing every change first.

    Before `brew uninstall --zap`, remove the hooks it added:
      /Applications/AgentSoundsBar.app/Contents/MacOS/AgentSoundsBar disconnect all
  EOS
end
