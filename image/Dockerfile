FROM debian:stretch-slim

LABEL maintainer="chestercheng <chester7864@gmail.com>"

# Default env variables
ENV LDAP_DOMAIN="example.org"
ENV LDAP_BASE_DN="dc=example,dc=org"
ENV LDAP_ROOT_PW="adminpassword"
ENV LDAP_BIND_PW="bindpassword"
ENV AD_URI="ldap://ad.example.org"
ENV AD_BASE_DN="dc=ad,dc=example,dc=org"
ENV AD_BIND_DN="cn=bind,dc=ad,dc=example,dc=org"
ENV AD_BIND_PW="adbindpassword"
ENV SSL_CERTS_PATH="/etc/ldap/assets/certs"
ENV SSL_CA_CRT_FILENAME="ca.crt"
ENV SSL_CRT_FILENAME="ldap.crt"
ENV SSL_KEY_FILENAME="ldap.key"
ENV SSL_DH_PARAM_FILENAME="dhparam.pem"
ENV LDAP_HOST=""
ENV LDAP_REPLICATION_HOSTS=""

# Add s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz

# Install requirement packages
RUN \
	tar xfz /tmp/s6-overlay.tar.gz -C / && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        gettext-base ldap-utils slapd \
        sasl2-bin \
        libsasl2-modules \
        libsasl2-modules-db \
        libsasl2-modules-gssapi-mit \
        libsasl2-modules-ldap \
        libsasl2-modules-otp \
        libsasl2-modules-sql &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /etc/ldap/slapd.d &&\
	rm -f /tmp/*.tar.gz

RUN /usr/sbin/usermod -a -G sasl openldap

# Reduce maximum number of number of open file descriptors to 1024
# otherwise slapd consumes two orders of magnitude more of RAM
# see https://github.com/docker/docker/issues/8231
RUN ulimit -n 1024

# Add OpenLDAP config files
COPY ./schema/*.schema /etc/ldap/schema/
COPY ./assets /etc/ldap/assets
COPY ./s6.d /etc/services.d

# Expose default ldap and ldaps ports
EXPOSE 389 636

ENTRYPOINT [ "/init" ]
