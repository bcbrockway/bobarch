FROM archlinux:base-devel AS aur-pkg-builder

RUN pacman -Syu --noconfirm --needed \
      git \
      go \
      pacman-mirrorlist \
      pigz \
      xz \
      zstd

# Speed up package building
RUN sed -i 's/^COMPRESSGZ=.*/COMPRESSGZ=(pigz -c -f -n)/' /etc/makepkg.conf
RUN sed -i 's/^COMPRESSBZ2=.*/COMPRESSBZ2=(pbzip2 -c -f)/' /etc/makepkg.conf
RUN sed -i 's/^COMPRESSXZ=.*/COMPRESSXZ=(xz -c -z - --threads=0)/' /etc/makepkg.conf
RUN sed -i 's/^COMPRESSZST=.*/COMPRESSZST=(zstd -c -z -q - --threads=0)/' /etc/makepkg.conf

# Create AUR "builder" user
RUN groupadd --system builder
RUN usr/sbin/useradd -m -g builder builder
RUN usr/sbin/echo '%builder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set up AUR "builder" user
USER builder
ENV PKGDEST=/pkg
WORKDIR /tmp
COPY scripts/build_aur_packages /build_aur_packages

ENTRYPOINT ["/build_aur_packages"]