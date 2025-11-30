class DailyDashboard < Formula
  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/1f/fd/c15ca37dbb82b4ba33b2c0bf8097e9ca98f85b71741208ad43fd79f71f4d/daily_dashboard-0.1.0.tar.gz"
  sha256 "09a4c1ef2cc654fd24230c2237a5720719a8f59c043c80e77fd7d3546b4fa3e9"
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
