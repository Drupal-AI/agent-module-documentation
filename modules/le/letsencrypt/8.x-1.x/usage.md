<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Letsencrypt provides an integrated solution to create a LetsEncrypt-issued SSL/TLS certificate.

---

Letsencrypt provides an integrated ACME client for obtaining a Let's Encrypt-issued SSL/TLS certificate
from within Drupal — handling the ACME HTTP-01 challenge (writing challenge files to
`.well-known/acme-challenge`) to prove domain control and issue/renew certificates. It is configured at
`letsencrypt.settings` (admin route gated by `administer site configuration`), in the Other package.

Use it to automate Let's Encrypt certificate issuance. It is an administration/security-infrastructure tool.
Security/operational points: it needs **filesystem write access** (to serve the challenge and store certs)
and manages the **ACME account key and issued private keys** — those must be stored securely (readable only
by the server, never web-exposed); restrict the admin config to trusted administrators. Automating TLS
certs is a **security-positive** outcome (encrypted connections), but the key material must be handled
carefully. It has no runtime access-control role. Configure the certificate issuance.

---

- Obtain a Let's Encrypt SSL/TLS certificate.
- Handle the ACME HTTP-01 challenge.
- Write challenge files to .well-known/acme-challenge.
- Issue/renew certificates.
- Configure at letsencrypt.settings.
- Gate admin config to administrators.
- Need filesystem write access.
- Store the ACME account key + private keys securely.
- Never web-expose the key material.
- Restrict admin config to trusted admins.
- Automate TLS (security-positive).
- Have no runtime access-control role.
- Configure certificate issuance.
- Handle ACME.
- Issue certs.
- Renew certificates.
- Manage certs.
- Configure the certificate.
- Handle TLS certs.
- Automate certificates.
