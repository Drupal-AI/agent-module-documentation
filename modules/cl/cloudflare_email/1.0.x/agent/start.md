<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Email (cloudflare_email) — agent index

**Sends Drupal outbound mail via the Cloudflare Email Service REST API; token held in a Key entity.**

- **Version:** 1.0.x (1.0.0-alpha1, experimental)
- **Core:** ^10.3 || ^11 · **Depends on:** system, key
- **Configure route:** `cloudflare_email.settings` → `/admin/config/system/cloudflare-email` (perm `administer cloudflare email`, restricted)
- **Key services:** `cloudflare_email.client` (`CloudflareEmailClient`, resolves token via `key.repository`), `cloudflare_email.transport`, `cloudflare_email.message_converter`; Mail plugin `Plugin/Mail/CloudflareEmail`; `Plugin/QueueWorker/CloudflareEmailQueueWorker`
- **Submodules:** `cloudflare_email_analytics` (report route + permission), `cloudflare_email_symfony_mailer_lite`
- **Security:** HTTPS endpoint, bearer token from a Key entity (secret kept out of config); TLS at default (no `verify=>false`); sandbox mode; typed exceptions. Admin route permission-gated. No anonymous mutating endpoints.

See [configure/settings.md](configure/settings.md)
