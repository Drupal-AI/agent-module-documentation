<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metatag Webform — agent index

Adds **per-webform meta tags**. A **Metatags** tab on each webform's Settings lets you set
Metatag values that are output on that webform's canonical page. No global settings page, no
permissions, no Drush, no services, no config schema of its own.

- **Set/read a webform's metatags: the form route, where it is stored, how tags get output** →
  [configure/webform-metatags.md](configure/webform-metatags.md)

Key facts:
- Form route: **`metatag_webform.settings_form`** →
  `/admin/structure/webform/manage/{webform}/metatags` (access = Webform `update` on that webform).
- Stored as a **`metatag_defaults`** config entity with id **`webform.<webform_id>`**
  (config `metatag.metatag_defaults.webform.<id>`), reusing Metatag's schema.
- Output via **`hook_metatags_alter()`** on the webform canonical route, merging the
  entity's `tags`.
- Auto-cleanup: `hook_entity_delete()` deletes `webform.<id>` when the webform is deleted;
  `hook_uninstall()` deletes all `webform.*` defaults.
