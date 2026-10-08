<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exif-DropzoneJS (exif_dropzonejs) — agent index

Submodule of Exif. Pre-loads image metadata (alt text + mapped fields + taxonomy terms) into the
DropzoneJS media-library upload form, reusing the parent module's media-type EXIF mapping. No config,
routes, permissions, services, or schema of its own.

Dependencies (`exif_dropzonejs.info.yml`): `file`, `image`, `taxonomy`, `dropzonejs:dropzonejs`,
`exif:exif`. `core_version_requirement: ^9 || ^10 || ^11 || ^12`.

- **The form-alter hook and how mapping is applied on upload** →
  [api/hook.md](api/hook.md)

Key facts:
- Single implementation file `exif_dropzonejs.module`:
  `exif_dropzonejs_form_media_library_add_form_dropzonejs_alter()`.
- Uses parent classes `\Drupal\exif\ExifContent` (`getDataFromFileUri`) and
  `\Drupal\exif\ExifHelper` (`fieldsForMapping`, `getTermByName`, `createTerm`,
  `announceFieldPreloaded`).
- Reads media-type third-party settings under key `exif` (`alt`, `field_map`) — the same config the
  parent sets on the media-type edit form.
- Only fills fields/alt that are currently empty.
- Post-update `exif_dropzonejs_post_update_fix_settings` (`exif_dropzonejs.post_update.php`) moves a
  legacy `exif.exif_dropzonejs.field_map` setting to `exif.field_map`.
- Parent module docs: `../../../../2.8.x/agent/start.md`.
