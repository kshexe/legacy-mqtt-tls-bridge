#!/usr/bin/with-contenv bashio
# ==============================================================================
# Generates a persistent self-signed RSA certificate for the legacy TLS1.1
# listener. A dedicated RSA cert is required because legacy embedded TLS
# clients (e.g. the Rinnai boiler) typically only support RSA key-exchange
# cipher suites, which an ECDSA certificate cannot satisfy.
# ==============================================================================
readonly CERT="/data/legacy_rsa.crt"
readonly KEY="/data/legacy_rsa.key"

if ! bashio::fs.file_exists "${CERT}" || ! bashio::fs.file_exists "${KEY}"; then
  bashio::log.info "Generating self-signed RSA certificate for the legacy TLS bridge"
  openssl req -x509 -newkey rsa:2048 -nodes \
    -keyout "${KEY}" -out "${CERT}" \
    -days 3650 -subj "/CN=legacy-mqtt-bridge"
fi
