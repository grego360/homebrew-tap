class DailyDashboard < Formula
  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/51/0f/c9276f7dfa47a48fa73e519c87e4966fe9004754af908bcc547a6013f94e/daily_dashboard-0.1.1.tar.gz"
  sha256 "556b0dd997ac332b2308a285b87ddc35edd5ac7f722c43a5a9ecaa7706a7a5f3"
  license "MIT"

  depends_on "python@3.12"

  def install
    python3 = "python3.12"

    # Create virtualenv with pip
    system python3, "-m", "venv", libexec

    # Install the package and dependencies
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", buildpath

    # Link the executable
    bin.install_symlink libexec/"bin/daily-dashboard"
  end

  def caveats
    <<~EOS
      To use network scanning features, run with sudo:
        sudo daily-dashboard

      Create a config file to get started:
        curl -o config.json https://raw.githubusercontent.com/grego360/daily-dashboard/main/config.example.json

      Edit config.json to add your feeds, location, and network targets.
    EOS
  end

  test do
    assert_match "Daily Dashboard", shell_output("#{bin}/daily-dashboard --version")
  end
end
