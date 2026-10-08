<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Icons — agent index

Adds one CKEditor 5 plugin, **`ckeditor5_icons_icon`** (toolbar item id `icon`, label "Icons"),
that opens a Font Awesome picker and inserts `<i class="fa-solid fa-heart">`. Everything is
configured **per text format** inside `editor.editor.<format>`. There is **no configure route**
(`configure: null`), no settings form, no permissions, no Drush, no hooks, no plugin types of
its own. It ships one service and three dynamically-registered metadata routes.

- **Enable the picker on a text format, and every config key under
  `settings.plugins.ckeditor5_icons_icon`** →
  [configure/text-format.md](configure/text-format.md)
- **The CKEditor 5 plugin definition, the markup/classes it emits, and the widget toolbar
  items** → [plugins/icon-plugin.md](plugins/icon-plugin.md)
- **The `ckeditor5_icons.CKEditor5Icons` service, the bundled Font Awesome metadata, the
  async metadata routes, and the `fontawesome` contrib integration** →
  [api/metadata-service.md](api/metadata-service.md)

Key facts:
- Config lives at `editor.editor.<format>` → `settings.toolbar.items` must contain `icon`, and
  `settings.plugins.ckeditor5_icons_icon` holds `fa_version`, `fa_styles`, `custom_metadata`,
  `async_metadata`, `recommended_enabled`, `recommended_icons`.
- The module does **not** load the Font Awesome CSS on the front end. The library must already
  be present (theme, CDN, or the `fontawesome` contrib module) or icons render blank.
- Bundled catalogues: Font Awesome **6.7.2** and **5.15.4** (`libraries/versions.yml`).
