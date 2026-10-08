<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Helper Preview (elasticsearch_helper_preview) — agent index
**Stages draft content into a temporary Elasticsearch index and redirects editors to a decoupled front-end preview URL.**

- **Version:** 8.0.x
- **Core:** ^9.4 || ^10
- **Depends on:** elasticsearch_helper
- **Settings route:** `elasticsearch_helper_preview.settings` → `/admin/config/search/elasticsearch_helper/preview` (permission `administer site configuration`).
- **Preview route:** `elasticsearch_helper_preview.preview` → `/elasticsearch-preview/{preview}`, `_custom_access: PreviewController::access`. **Services:** `preview_handler`, private-tempstore param converter, preview event subscriber. **Cron:** garbage-collects expired preview indices.

**Security:** Preview route access = `AccessResult::allowedIf($entity->access('update'))` (`src/Controller/PreviewController.php`) — only users who can edit the entity may preview, so unpublished content does not leak. Redirect is a `TrustedRedirectResponse` to admin-configured base URL + configured path (not raw user input); payload is per-user private tempstore. Settings route is admin-gated.

See [configure/preview.md](configure/preview.md)