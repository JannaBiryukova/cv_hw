FROM fedora:32

RUN mkdir -p /etc/yum.repos.d && \
    echo '[fedora]' > /etc/yum.repos.d/fedora.repo && \
    echo 'name=Fedora 32 - x86_64' >> /etc/yum.repos.d/fedora.repo && \
    echo 'baseurl=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/32/Everything/x86_64/os/' >> /etc/yum.repos.d/fedora.repo && \
    echo 'enabled=1' >> /etc/yum.repos.d/fedora.repo && \
    echo 'gpgcheck=1' >> /etc/yum.repos.d/fedora.repo

RUN mkdir -p /etc/yum.repos.d && \
    echo '[updates]' > /etc/yum.repos.d/updates.repo && \
    echo 'name=Fedora 32 - x86_64 - Updates' >> /etc/yum.repos.d/updates.repo && \
    echo 'baseurl=https://archives.fedoraproject.org/pub/archive/fedora/linux/updates/32/Everything/x86_64/' >> /etc/yum.repos.d/updates.repo && \
    echo 'enabled=1' >> /etc/yum.repos.d/updates.repo && \
    echo 'gpgcheck=1' >> /etc/yum.repos.d/updates.repo

RUN dnf -y update && dnf install -y \
    texlive-collection-latexrecommended \
    texlive-collection-fontsrecommended \
    texlive-collection-pictures \
    texlive-collection-latex \
    texlive-collection-langcyrillic \
    && dnf clean all

WORKDIR /resume

COPY CV/resume.tex CV/resume.cls CV/mypic.png ./

RUN pdflatex -interaction=nonstopmode resume.tex || true && \
    pdflatex -interaction=nonstopmode resume.tex || true && \
    test -s resume.pdf
