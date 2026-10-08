# Drimage (drimage_improved) — agent index

"Dynamic Responsive Image" formatter that measures each image's rendered size in the browser and
generates a matching image style on the fly. Fork/successor of `drimage`. Depends on core `image`.
Provides config schema + a Drush command; no permissions of its own.

- **Global settings (`/admin/config/media/drimage_improved`), the formatter settings & handling modes**
  → [configure/settings.md](configure/settings.md)
- **The on-the-fly image route, `DrimageManager` flow, and dimension validation** →
  [api/route.md](api/route.md)
- **Alter hooks (`hook_drimage_improved_image_style_alter`, proxy cache periods)** →
  [hooks/alter.md](hooks/alter.md)
- **Drush command `drimage_improved:delete-styles`** → [drush/delete-styles.md](drush/delete-styles.md)

Submodule (own docs):
- `drimage_s3fs` → [../../modules/drimage_s3fs/1.0.x/agent/start.md](../../modules/drimage_s3fs/1.0.x/agent/start.md)

Key facts:
- Route `drimage_improved.image`: `/drimage/{width}/{height}/{fid}/{iwc_id}/{format}`,
  `_permission: 'access content'`. Controller `DrImageController` → `DrimageManager::image()`.
- Generated styles are named `drimage_improved_<w>_<h>` (or `..._focal_<w>_<h>`, or `..._<w>_<h>_<iwc_id>`).
- Settings config object `drimage_improved.settings` (see configure doc for keys/defaults).
