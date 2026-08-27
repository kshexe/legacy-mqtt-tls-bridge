# Legacy MQTT TLS Bridge

Accepts old TLS1.1 MQTT connections on port **8885** and forwards them, in
plaintext, to your existing Mosquitto broker (default: `core-mosquitto:1883`).

Built for legacy embedded devices — e.g. a Rinnai SmartLink boiler — whose
TLS stack only supports TLS1.1 and RSA key-exchange cipher suites, which a
modern ECDSA certificate (as used by the standard Mosquitto add-on) cannot
satisfy.

This add-on does not touch your existing Mosquitto configuration at all; it
only terminates legacy TLS and relays plaintext MQTT to it internally.

## Options

| Option | Default | Description |
|---|---|---|
| `target_host` | `core-mosquitto` | Hostname of the broker to forward to |
| `target_port` | `1883` | Plaintext MQTT port on that broker |

## How it works

1. On first start, generates a persistent self-signed RSA certificate
   (`/data/legacy_rsa.crt` / `/data/legacy_rsa.key`), stored under the
   add-on's own persistent storage so it survives restarts/updates.
2. Runs [stunnel](https://www.stunnel.org/) pinned to TLS1.1 with a wide
   cipher list (`ALL:@SECLEVEL=0`) on port 8885, forwarding decrypted
   traffic to `target_host:target_port`.
