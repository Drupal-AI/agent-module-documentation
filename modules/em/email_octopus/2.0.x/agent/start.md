<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Octopus (email_octopus) — agent index

**Connects Drupal to the EmailOctopus API: a placeable subscribe-form block per list, plus admin forms to configure the API key and browse list contacts.**

- **Version:** 2.0.x (2.0.3)
- **Core:** ^10 || ^11
- **Routes:** `email_octopus.configuration_form` (`/admin/config/credentials`), `email_octopus.list_form` (`/admin/config/users-list`), `email_octopus.subscribe_form` (`/admin/config/susbcribe`) — all `_permission: 'administer'`
- **Block:** `email_octopus_subscribe_form_block` → renders `OctopusSubscribeForm`
- **API:** EmailOctopus v1.5 over HTTPS via Guzzle `http_client` (TLS verification default/on)
- **Config:** `octopus.adminsettings:api_key` (plaintext config)

**Security posture:** Admin routes are gated, but by the permission string `administer`, which is **not a defined permission** → fails closed (uid 1 only); not a hole but a misconfiguration. Findings to note (see final report): API key stored in **plaintext config** (no Key entity); the **anonymous subscribe block has no CAPTCHA/rate-limiting** (list-spam / API-quota abuse). No `verify => false`; no unauthenticated mutating server endpoint of the site's own. See [configure/setup.md](configure/setup.md).
