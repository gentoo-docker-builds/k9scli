# ------------------- portage tree
#COPY --from=gentoo/portage:latest /var/db/repos/gentoo /var/db/repos/gentoo
FROM ghcr.io/gentoo-docker-builds/gendev:latest as builder

# ------------------- emerge
RUN emerge -C sandbox
RUN echo 'sys-cluster/k9scli ~amd64' >> /etc/portage/package.accept_keywords
RUN ROOT=/k9scli FEATURES='-usersandbox' emerge sys-cluster/k9scli

# ------------------- shrink
# ToDo

# ------------------- empty image
FROM scratch
COPY --from=builder /k9scli /
