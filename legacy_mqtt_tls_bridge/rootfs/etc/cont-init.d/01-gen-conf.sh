#!/usr/bin/with-contenv bashio
# ==============================================================================
# Generates the stunnel configuration from the addon options.
# ==============================================================================
TARGET_HOST=$(bashio::config 'target_host')
TARGET_PORT=$(bashio::config 'target_port')

cat > /etc/stunnel/stunnel.conf <<EOF
pid = /var/run/stunnel.pid
foreground = yes
output = /dev/stdout
debug = 4

[legacy-mqtt]
accept = 8885
connect = ${TARGET_HOST}:${TARGET_PORT}
cert = /data/legacy_rsa.crt
key = /data/legacy_rsa.key
sslVersionMin = TLSv1.1
sslVersionMax = TLSv1.1
ciphers = ALL:@SECLEVEL=0
EOF

bashio::log.info "Legacy TLS1.1 bridge: 8885 -> ${TARGET_HOST}:${TARGET_PORT}"
