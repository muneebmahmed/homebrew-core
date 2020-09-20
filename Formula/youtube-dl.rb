class YoutubeDl < Formula
  desc "Download YouTube videos from the command-line"
  homepage "https://ytdl-org.github.io/youtube-dl/"
  url "https://github.com/ytdl-org/youtube-dl/releases/download/2020.09.14/youtube-dl-2020.09.14.tar.gz"
  sha256 "0657c19661bbec99117a2eb2b5a2d26d3f0b0a58703035f1ebf76bb5f2858ea3"
  license "Unlicense"

  bottle do
    cellar :any_skip_relocation
    sha256 "1cedb2cdd25ae6096567bc8abb6257460f3a035979ace09f97826ff9e2d624da" => :mojave
  end

  head do
    url "https://github.com/ytdl-org/youtube-dl.git"
  end

  depends_on "pandoc" => :build
  depends_on "python@3.8" if MacOS.version <= :mojave

  def install
    # Explicitly use `python3` instead of the unversioned `python`, which may
    # point to a Python2 installation. Use -B flag to rebuild included binary.
    args = %W[
      -B
      PYTHON=/usr/bin/env\ python3
      PREFIX=#{prefix}
    ]
    system "make", *args
    bin.install "youtube-dl"
    man1.install "youtube-dl.1"
    bash_completion.install "youtube-dl.bash-completion"
    zsh_completion.install "youtube-dl.zsh" => "_youtube-dl"
    fish_completion.install "youtube-dl.fish"
  end

  test do
    # commit history of homebrew-core repo
    system "#{bin}/youtube-dl", "--simulate", "https://www.youtube.com/watch?v=pOtd1cbOP7k"
    # homebrew playlist
    system "#{bin}/youtube-dl", "--simulate", "--yes-playlist", "https://www.youtube.com/watch?v=pOtd1cbOP7k&list=PLMsZ739TZDoLj9u_nob8jBKSC-mZb0Nhj"
  end
end
