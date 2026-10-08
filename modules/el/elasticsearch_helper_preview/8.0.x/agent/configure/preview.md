<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Elasticsearch Helper Preview

1. **Settings** — `/admin/config/search/elasticsearch_helper/preview` (permission `administer site configuration`): set the front-end application **base URL** and the temporary **preview index expiration**.
2. **Per index** — on an `elasticsearch_content_index` form, check **Enable preview** and set a **Preview path** template. Placeholders: field names plus `_index`, `_id` (e.g. `/preview/{_index}/{_id}`).
3. **Editing** — the node form gains a preview button (added by `PreviewHandler::alterForm`). It stores the built document in the private tempstore and links to `/elasticsearch-preview/{preview}`.

## Runtime flow
- `ContentPreviewConverter` loads the tempstore entry for `{preview}`.
- `PreviewController::access(Preview $preview)` → `allowedIf($entity->access('update'))` — edit access required.
- `PreviewController::preview()` → `TrustedRedirectResponse(base_url . preview_path)`, uncached.
- Cron (`elasticsearch_helper_preview_cron`) calls `PreviewHandler::garbageCollection()` to drop expired preview indices.

## Access note
Preview is restricted to users with `update` access on the entity, so draft/unpublished content is not exposed to unauthorized visitors. The redirect base URL is admin-configured, not user-supplied.
