<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editor Advanced Image — agent index

CKEditor 5 plugin that lets authors set `title`, `class`, `id` on inline images and apply a
default class. **No configure route, no admin page, no permissions, no Drush.** Configuration
is per text format, stored inside the `editor.editor.<format>` config entity at
`settings.plugins.editor_advanced_image_image`.

- **Enable it on a text format, allowlist attributes, set a default class / read where it is stored** →
  [configure/text-format.md](configure/text-format.md)
- **The CKEditor5 plugin PHP surface (dynamic JS config, elements subset, supported attributes)** →
  [plugins/ckeditor5-plugin.md](plugins/ckeditor5-plugin.md)

Key facts:
- CKEditor5 plugin id: `editorAdvancedImage.EditorAdvancedImage`; Drupal plugin id
  `editor_advanced_image_image`. Requires the `ckeditor5_image` plugin to be active.
- Config keys under `settings.plugins.editor_advanced_image_image`:
  `disable_balloon` (bool), `default_class` (string), `enabled_attributes` (sequence of
  `title`/`class`/`id`). Default: `enabled_attributes: ['class']`.
- Only `title`, `class`, `id` are supported; the plugin declares `<img title class id>`.
