FROM golang

RUN apt-get update -y && apt-get install -y vim

COPY  vimrc  /root/.vimrc

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN go env -w GOPROXY=https://goproxy.cn,https://mirrors.aliyun.com/goproxy/,direct
RUN vim +PlugInstall +qall
RUN vim +GoInstallBinaries +qall

