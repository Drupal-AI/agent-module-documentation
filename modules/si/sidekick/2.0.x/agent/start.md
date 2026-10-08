<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sidekick (sidekick) — agent index

**Editorial assistant that pulls ChatGPT content suggestions from a remote Sidekick API and shows them while authoring nodes.**

- **Version:** 2.0.x (2.0.0-beta1)
- **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Depends:** node, dynamic_page_cache, token
- **Config route:** `sidekick.settings_form` → `/admin/config/services/sidekick` (permission `administer sidekick configuration`)
- **Permissions:** `administer sidekick configuration`, `sidekick content generation`
- **Service:** `sidekick.service` (`SidekickService`) — Guzzle calls with `Authorization: Bearer <api_key>` (config `sidekick.settings:api_key`).
- **UI:** custom `ImageWidget` + Twig template.

**Security:** admin config route permission-gated; generation gated by `sidekick content generation`; TLS uses Guzzle defaults (verification on). Note: the API key is stored plaintext in exportable config (not the Key module), and generation calls a paid remote API — restrict the generation permission to control cost.

See [configure/sidekick.md](configure/sidekick.md)
