# LAZYGIT

wget
https://github.com/jesseduffield/lazygit/releases/download/v0.54.2/lazygit_0.54.2_linux_x86_64.tar.gz


# xterm-ghostty
  방법 1: 로컬에서 terminfo 파일 추출해서 서버로 전송

  # 로컬에서 terminfo 추출
  infocmp xterm-ghostty > xterm-ghostty.terminfo

  # 서버로 파일 전송 (scp 사용)
  scp xterm-ghostty.terminfo user@server:/tmp/

  # 서버에서 설치
  ssh user@server "tic /tmp/xterm-ghostty.terminfo"

  방법 2: SSH 연결 시 TERM 환경변수 변경

  # ~/.ssh/config에 추가
  Host your-server
      SetEnv TERM=xterm-256color

  또는 연결할 때마다:
  ssh -o SendEnv=TERM user@server
  export TERM=xterm-256color

  방법 3: 서버의 bashrc/zshrc에 설정

  서버의 ~/.bashrc 또는 ~/.zshrc에 추가:
  if [[ "$TERM" == "xterm-ghostty" && ! -f
  "/usr/share/terminfo/x/xterm-ghostty" ]]; then
      export TERM=xterm-256color
  fi

  추천: 방법 1
