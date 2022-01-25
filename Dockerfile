FROM mirrors.tencent.com/taiji_light/g-tlinux2.2-python3.6:latest

RUN localedef -c -f UTF-8 -i en_US en_US.UTF-8
ENV PYTHONIOENCODING=utf-8
ENV LC_ALL=en_US.UTF-8

RUN rpm --rebuilddb && \
    yum update -y && \
    yum groupinstall -y "development tools" && \
    yum install -y zlib zlib-devel bzip2-devel openssl openssl-devel libffi-devel ncurses-devel xz-devel python3-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel expat-devel

RUN rpm --rebuilddb && \
    yum install python36 -y && \
    yum install python36-devel -y && \
    yum install python3-pip -y && \
    pip3 install --upgrade pip

RUN pip3 install torch==1.8.2+cu102 torchvision==0.9.2+cu102 -f https://download.pytorch.org/whl/lts/1.8/torch_lts.html

COPY . /opt/app
WORKDIR /opt/app
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install -I tl2

RUN pip3 install -e torch_fidelity_lib
RUN pip3 install -e pytorch_ema_lib
