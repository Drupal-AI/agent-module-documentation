<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flush Single Image Styles (flush_single_image) — agent index

Flushes the image-style derivatives generated for **one source image**, instead of core's
all-or-nothing "flush this entire image style". Two actions per derivative: **Unlink** (delete
the cached derivative so core lazily regenerates it) or **Regenerate** (rebuild it immediately).

- Core requirement `^8.8 || ^9 || ^10 || ^11`. Dependencies: core `image` and `action`.
- `configure` route: `flush_single_image.settings.form` (`/admin/config/flush-single-image/settings`).
- Defines **permissions** (2), a **Drush** command, an **Action** plugin, a **migrate process**
  plugin, and a `hook_form_alter` widget on media edit forms. Defines **no** plugin *types* and
  ships **no** config schema.

What you'd do:
- **Call the flush service from code** → [api/service.md](api/service.md)
- **Flush an image interactively (admin form)** → [configure/flush-form.md](configure/flush-form.md)
- **Choose which media types count as images** → [configure/settings.md](configure/settings.md)
- **Grant flush rights to editors** → [permissions/permissions.md](permissions/permissions.md)
- **Flush from the CLI / a deploy script** → [drush/commands.md](drush/commands.md)
- **Flush as a bulk operation on media** → [plugins/action.md](plugins/action.md)
- **Flush derivatives during a migration** → [plugins/migrate.md](plugins/migrate.md)
- **Add a flush widget to the media edit form** → [hooks/form-alter.md](hooks/form-alter.md)

Key facts:
- Service id: `flush_single_image` (class `Drupal\flush_single_image\FlushSingleImage`,
  interface `FlushSingleImageInterface`). Methods: `flush($path, $action)`,
  `flushStyle($path, $style_id, $action)`, `getStylePaths($path)`.
- Action constants: `FlushSingleImage::ACTION_UNLINK` (`1`, default), `ACTION_REGENERATE` (`2`).
- Routes: `flush_single_image.flush` (`/admin/config/media/image-styles/flush-single`),
  `flush_single_image.settings.form` (`/admin/config/flush-single-image/settings`). Both require
  `administer flush_single_image`.
- Permissions: `administer flush_single_image` (`restrict access: true`), `flush media image`.
- Config object: `flush_single_image.settings`, key `media_image_types` (map of media-type id → id/0).
- Action plugin id: `flush_single_image_action` (type `media`). Migrate process plugin id:
  `flush_single_image`. Drush command: `flush_single_image` (alias `fsi`).
- An action link "Flush single image" is placed on the image-styles collection page
  (`entity.image_style.collection`) linking to the flush form.
