class DailyDashboard < Formula
  include Language::Python::Virtualenv

  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/1f/fd/c15ca37dbb82b4ba33b2c0bf8097e9ca98f85b71741208ad43fd79f71f4d/daily_dashboard-0.1.0.tar.gz"
  sha256 "09a4c1ef2cc654fd24230c2237a5720719a8f59c043c80e77fd7d3546b4fa3e9"
  license "MIT"

  depends_on "python@3.12"

  resource "textual" do
    url "https://files.pythonhosted.org/packages/source/t/textual/textual-0.85.2.tar.gz"
    sha256 "e67ef8c79730a822e46e6f1f63c1d3a9a3a5e4f37ce87a9f6ffae467ba6c4c3e"
  end

  def install
    virtualenv_install_with_resources
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
