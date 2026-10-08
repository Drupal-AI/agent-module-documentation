<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# media_library_bulk_upload — agent start

Adds a bulk-upload screen to Drupal's Media Library so editors turn many uploaded files
into media entities at once. Reuses core's file widget + the Media Library UI (no
DropzoneJS). Depends on core `media_library`. Defines **no** plugin types, Drush commands,
or templates.

Routes (all `_admin_route`):
- `media_library.bulk_upload.list` → `/admin/content/media/bulk-upload` — landing page listing bulk-uploadable media types.
- `media_library.bulk_upload.upload_form` → `/admin/content/media/bulk-upload/{media_type}` — the media library scoped to one type, unlimited cardinality.
- `media_library_bulk_upload.settings` → `/admin/config/media/media-library-bulk-upload-config` — settings form (permission `administer media`).

Also: registers Media Library opener service `media_library.opener.bulk_upload`; hides the
library's row-select column while on the bulk-upload route (`hook_ENTITY_TYPE_load` on the
`media_library` view); nests its menu link under Content → Media when Admin Toolbar Extra
Tools is enabled.

- Limit which media types are offered / settings key `media_types` → [configure/settings.md](configure/settings.md)
- Who can bulk-upload (dynamic per-type permissions + access logic) → [permissions/permissions.md](permissions/permissions.md)
