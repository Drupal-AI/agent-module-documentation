<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YourOwnPrivate VPN (yopvpn) — agent index

**Provisions a WireGuard VPN on a user-owned VPS over SSH and stores the generated config/QR on a per-user `vpn` node.**

- **Version:** 1.0.x — core `^10 || ^11`. Provides a `vpn` content type (host, user, wireguard_conf, qr_code fields).
- **Flow:** node form shows per-user RSA-4096 SSH keypair (phpseclib, stored in `user.data`); saving a published VPN node runs a Batch of remote commands via phpseclib `SSH2`/`SFTP` (apt update, Docker, `lscr.io/linuxserver/wireguard`), then reads `peer1.conf`/`peer1.png` back into node fields. Shell args built with `escapeshellarg`; host validated as IP/hostname.
- **Access:** `hook_node_access` forbids non-owners (admins bypass) for view/update/delete of `vpn` nodes; `hook_node_view` re-checks. Command logging logs step name only, not the command.
- **Security observations:** SSH **private key stored in `user.data`** and rendered into a disabled form textarea (`yopvpn.module`); WireGuard config/QR (VPN secrets) stored in node fields — protected only by owner-only node access. Remote SSH **host key is not verified/pinned** (phpseclib default) → possible first-connect MITM. No hardcoded secrets; no disabled-TLS (uses SSH). See [configure/provisioning.md](configure/provisioning.md).
