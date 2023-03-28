ARG COREOS_VERSION=${COREOS_VERSION:-stable}

FROM ghcr.io/ublue-os/ucore:${COREOS_VERSION}
ARG COREOS_VERSION

COPY etc /etc

# copy in all separately built RPM files
COPY --from=ghcr.io/bsherman/ucore-kmods:${COREOS_VERSION} / /tmp/rpms

# Install needed packages
RUN cd /tmp/rpms \
    && mkdir -p /var/lib/alternatives \
    && rpm-ostree install \
        cockpit-machines \
        libvirt-daemon-kvm \
        *.rpm \
    && git clone https://github.com/45drives/cockpit-zfs-manager.git \
    && cp -r cockpit-zfs-manager/zfs /usr/share/cockpit


# Finalize
RUN mv /var/lib/alternatives /staged-alternatives \
    && rm -fr /tmp/* /var/* \
    && rpm-ostree cleanup -m \
    && ostree container commit \
    && mkdir -p /var/lib && mv /staged-alternatives /var/lib/alternatives
