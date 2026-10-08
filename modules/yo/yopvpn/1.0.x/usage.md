<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
YourOwnPrivate VPN provisions a self-hosted WireGuard VPN on a VPS you own: you create a "VPN" node with the server's host/user, and the module SSHes in to install WireGuard via Docker and stores the resulting client config and QR code on the node.
---
Installing the module creates a `vpn` content type with fields for host, user, WireGuard config and QR code. On the node form, per-user SSH keypairs (RSA 4096, generated with phpseclib and stored in `user.data`) are shown read-only with a "Regenerate keys" action; the public key is uploaded by the user to their VPS provider. On save of a published VPN node, a Batch runs a fixed sequence of remote commands over SSH/SFTP (phpseclib `SSH2`/`SFTP`, authenticating with the stored private key): apt update, install Docker, launch the linuxserver/wireguard container (options built with `escapeshellarg`), then read back `peer1.conf` into `field_wireguard_conf` and the `peer1.png` QR into `field_qr_code` (base64, rendered as an inline image on the node). Host input is validated as an IP or hostname.

Access is owner-scoped: `hook_node_access` forbids anyone but the node owner (admins bypass) from view/update/delete of `vpn` nodes, and `hook_node_view` re-checks ownership. Command logging deliberately logs only the step name, not the command, to avoid leaking secrets. Note the sensitive material this module handles: the per-user SSH **private** key is stored in `user.data` and rendered into a disabled textarea on the form, and the WireGuard config/QR (VPN secrets) are stored in node fields — all protected only by the owner-only node access, so private-file/field hardening is worth considering. The remote SSH host key is not pinned/verified (phpseclib default), so first-connection MITM is possible on an untrusted network.

Setup: enable the module, go to Content → Add content → VPN, copy the shown SSH public key to your VPS provider, create the VPS (latest Ubuntu), enter its IP and user, save to run the provisioning batch, then import the produced WireGuard config or scan the QR into a WireGuard client.

---

- Provision a self-hosted WireGuard VPN on your own VPS
- Create a 'VPN' node describing a target server
- Generate a per-user RSA-4096 SSH keypair automatically
- Copy the SSH public key to your VPS provider account
- Install Docker and WireGuard on the VPS over SSH
- Run provisioning as a Drupal batch of remote commands
- Pull the generated WireGuard peer config back into the node
- Store the WireGuard QR code image on the node for mobile import
- Restrict VPN nodes to their owner via hook_node_access
- Regenerate SSH keys and re-provision servers
- Validate the host field as an IP address or hostname
- Import the config into a WireGuard client app
- Scan the QR code into a mobile WireGuard app
- Bypass geo-restrictions with your own VPN endpoint
- Avoid third-party commercial VPN providers
- Delete a VPN node and redirect back to the content list
