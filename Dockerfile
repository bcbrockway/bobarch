FROM greyltc/archlinux-aur

RUN pacman -Syu --noconfirm --needed \
    archiso

WORKDIR /app

COPY ./packages-aur.x86_64 .

USER aurbuilder
RUN cat /app/packages-aur.x86_64 | yay -Syu --removemake --needed --noprogressbar --noconfirm -