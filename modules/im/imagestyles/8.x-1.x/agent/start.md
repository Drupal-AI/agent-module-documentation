<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Style Preview (imagestyles) — agent index

A procedural module (no plugins, no entities, no services) that renders a preview of **every
image style derivative** on the canonical page of an **image media entity**, plus a one-field
admin settings form. Package `Media`. License GPL-2.0-or-later. `core_version_requirement:
^8.8 || ^9 || ^10 || ^11`. Version 8.x-1.4.

- **Settings form + the `imagestyles.settings` config object** → [config/settings.md](config/settings.md)
- **How the media-page preview is built (the preprocess hook)** → [display/media-preview.md](display/media-preview.md)

## What it actually is (from source)

- **Dependencies (undeclared):** `imagestyles.info.yml` declares **no `dependencies:`**, but the
  code hard-requires core **`image`** (`Drupal\image\Entity\ImageStyle`) and **`media`**
  (`hook_preprocess_media`). README also requires **Standalone media URLs** on at
  `/admin/config/media/media-settings` so the media page exists. Treat image + media as real deps.
- **One route** (`imagestyles.routing.yml`): `imagestyles.imagestyles_settings` →
  `path: admin/config/media/image-styles/imagestyles`, `_form:
  \Drupal\imagestyles\Form\SettingsForm`, `_permission: 'access administration pages'`,
  `_admin_route: TRUE`. Menu link (`imagestyles.links.menu.yml`) sits under
  `entity.image_style.collection`.
- **One form:** `SettingsForm` (`src/Form/SettingsForm.php`, extends `ConfigFormBase`, form id
  `imagestyles_settings`) — a `checkboxes` element `expanded_styles` listing every
  `ImageStyle::loadMultiple()` plus an `original` option; writes config `imagestyles.settings`.
- **No config schema and no config/install:** there is **no `config/` directory**. The
  `imagestyles.settings` object is created only when the form is saved; loading the media page
  reads it defensively (`?? []`).
- **`imagestyles.module`** implements `hook_help` and `hook_preprocess_media`, with helper
  functions (all procedural, `imagestyles_*`) that build the per-style `details` render arrays.
- **No permissions of its own** (no `*.permissions.yml`), **no Drush**, **no services**, **no
  plugins**. `imagestyles.yml` is a stray legacy `core: 8.x` info file, unused.

## Operate it

1. Enable the module (and ensure `image` + `media` are on). Enable Standalone media URLs.
2. Visit any image media page, e.g. `/media/123` — styles render as collapsible previews.
3. Optionally choose defaults-expanded styles at `admin/config/media/image-styles/imagestyles`.
