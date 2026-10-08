<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Photos — agent index

Photo-album module. An **album is a node of type `photos`**; its pictures are **`photos_image`
content entities**. Multi-upload (Plupload/ZIP/directory), image styles, cover images, sorting,
comments, search, media source. Depends on `field_ui, image, media, node, views`. Ships a
submodule **photos_access** (per-album privacy).

- **Global settings (`photos.settings` keys, admin routes, structure/field-UI)** →
  [configure/settings.md](configure/settings.md)
- **Data model: the `photos` album node, the `photos_image` entity, upload service, DB tables** →
  [api/model.md](api/model.md)
- **The plugins it provides (formatters, block, filter, media source, search, views, migrate)** →
  [plugins/plugins.md](plugins/plugins.md)
- **Permissions (7) and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `configure` route: `photos.admin` (`/admin/structure/photos`, field-UI base). Main settings
  form: `photos.admin.config` (`/admin/config/media/photos`); legacy: `photos.admin.legacy.config`.
- Album collection: `/admin/content/photos` (entity.photos_image.collection).
- Upload service: `photos.upload` (`Drupal\photos\PhotosUpload`).
- Config object: `photos.settings` (schema in `photos.schema.yml`).
- Submodule docs: `../modules/photos_access/6.1.x/`.
