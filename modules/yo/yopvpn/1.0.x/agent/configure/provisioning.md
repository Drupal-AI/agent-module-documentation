<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provisioning a WireGuard VPN with YourOwnPrivate VPN

## What it creates
Enabling the module installs a **VPN** content type (`vpn`) with fields:
`field_host`, `field_user`, `field_wireguard_conf`, `field_qr_code`.

## Per-user SSH keys
- On first visit to the VPN node form, an RSA-4096 keypair is generated with
  phpseclib and stored in `user.data` (`private_key`, `public_key`) for the
  current user. Both are shown read-only; **Regenerate keys** deletes and
  recreates them (affects all that user's servers).
- The submit handler ignores posted key values and always uses the stored keys,
  regenerating if missing.

## Steps
1. Go to **Content → Add content → VPN**.
2. Copy the shown **SSH public key** into your VPS provider account.
3. Create a VPS (latest Ubuntu) selecting that SSH key.
4. Enter the server IP/hostname in **Host** and the login user (usually `root`)
   in **User**; save the node (must be published).
5. A Batch connects over SSH/SFTP and runs: `apt update`, install Docker,
   launch the `lscr.io/linuxserver/wireguard` container, then pull `peer1.conf`
   into `field_wireguard_conf` and `peer1.png` (QR) into `field_qr_code`.
6. On the node view (owner-only), import the WireGuard config or scan the QR into
   a WireGuard client.

## Access & security notes
- `hook_node_access` restricts view/update/delete of `vpn` nodes to the owner
  (admins bypass).
- The SSH **private key** lives in `user.data` and is echoed into a disabled
  textarea on the form; the WireGuard config/QR are stored in node fields. All
  are protected only by owner-only node access — consider private-field handling
  if the threat model warrants it.
- phpseclib does not verify the remote host key by default; provisioning a server
  over an untrusted network is subject to first-connection MITM.
