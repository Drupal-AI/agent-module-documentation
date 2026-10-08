<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Letsencrypt — agent index

Integrated **ACME client to obtain a Let's Encrypt SSL/TLS certificate** (HTTP-01 challenge via
`.well-known/acme-challenge`; issue/renew). Admin route gated by `administer site configuration`. Config at
`letsencrypt.settings`. Version **8.x-1.14**. Core `^8||^9||^10||^11`.

Admin/security-infra — needs filesystem write + manages the **ACME account key + private keys** (store
securely, never web-expose); restrict admin config. Automating TLS is **security-positive**. No runtime
access role.
