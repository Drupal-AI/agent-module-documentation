<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AutoAlt.ai (autoalt) — agent index

**Generates AI alt text for images via the AutoAlt.ai API, single and bulk.**

- **Version:** 2.0.x (2.0.5), core `^10 || ^11`, package Content, depends on `drupal:image`
- **Config route:** `autoalt.settings` → `/admin/config/content/autoalt` (perm `administer site configuration`) — stores `api_key`
- **Bulk UI:** `/admin/config/media/autoalt/bulk-alt`; history `/admin/content/autoalt/history`
- **Endpoints:** `POST /api/autoalt/generate` (`access content`), `save-alt` (`administer media`), `list-fids`/`availcredit`/`totalImagesCount`/`shortAltTextCount`/`processedByAutoaltCount` (`administer site configuration`), `history`/`history_page` (`access content`), `get-data-from-plugin` (`access administration pages`)
- **Outbound:** `https://ahxdfj.autoalt.ai/api/...` via `@http_client` (default TLS verify).

See [api/endpoints.md](api/endpoints.md) and [configure/settings.md](configure/settings.md)
