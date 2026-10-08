<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Media Video (drowl_media_video) — agent index

Tiny helper submodule of the DROWL Media project. Attaches an admin JS library to the core video
media form. Version **4.0.18**, dir `4.0.x`. Core `^10.3 || ^11`. License GPL-2.0-or-later.

## Dependencies

`drowl_media` only (`drowl_media_video.info.yml`).

## What it provides

- One hook, `drowl_media_video_form_media_video_form_alter()` (`drowl_media_video.module`): attaches
  library `drowl_media_video/admin` to `$form['field_media_video_file']['widget']`.
- One library `admin` (`drowl_media_video.libraries.yml`): `dist/js/drowl_media.admin.video.js`,
  deps `core/drupal`, `core/jquery`.
- No config, no config schema, no routes, no permissions, no services, no Drush, no templates.

## Detail

- Behavior + workaround context → [api/overview.md](api/overview.md)
