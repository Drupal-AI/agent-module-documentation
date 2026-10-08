<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 4 - LTS re-publishes the CKEditor 4 WYSIWYG editor that Drupal core removed in favour of CKEditor 5, so a site can keep its existing CKEditor 4 text formats, toolbars and custom plugins working on Drupal 9.4 through 11 without migrating the editor immediately.

---

Drupal core shipped CKEditor 4 for years and then removed it when it adopted CKEditor 5, which is a different editor with a different plugin architecture. Migrating a site that has custom CKEditor 4 plugins and carefully-tuned toolbars is real work. This module packages the former core `ckeditor` module together with a bundled CKEditor 4 JavaScript build (library version `4.25.1-lts`) and re-registers it under the same machine name `ckeditor` and the same editor plugin id `ckeditor`, so existing `editor` configuration entities keep binding to it with no config changes. It adds one thing the core module never had: a settings page at `/admin/config/ckeditor-lts/settings` where you enter the CKEditor 4 LTS license key, which the module injects into the editor's client-side settings as `licenseKey`. It also re-creates a `core/ckeditor` library alias so other code that still depends on that library continues to resolve, and it keeps the CKEditorPlugin plugin type (annotation `@CKEditorPlugin`, manager `plugin.manager.ckeditor.plugin`) so custom CKEditor 4 plugins load unchanged. Enabling it alongside a previously-installed core/contrib `ckeditor` may require clearing the PHP user cache (APCu/WinCache), which the settings page offers a button for.

Use it when a CKEditor 5 migration cannot be done on core's timetable and you need the CKEditor 4 editor, its toolbars and its plugins to keep functioning while you plan that migration. It depends only on core `editor`, defines no permissions and no drush commands, and its settings live in the config object `ckeditor.lts.settings`.

---

- Keep CKEditor 4 working after core removed it for CKEditor 5.
- Stay on Drupal 10 or 11 without migrating the editor right away.
- Preserve existing CKEditor 4 text formats and toolbar configuration.
- Keep custom `Plugin/CKEditorPlugin` plugins loading unchanged.
- Enter and store the CKEditor 4 LTS license key via the settings page.
- Set the license key from drush or PHP by writing `ckeditor.lts.settings:license_key`.
- Read the configured license key through `ckeditor.lts.config_handler.settings`.
- Replace a previously-installed core or contrib `ckeditor` module.
- Swap from the open-source CKEditor 4 to the LTS build in place.
- Clear the APCu/WinCache user cache after swapping modules.
- Register a new CKEditor 4 toolbar button through the CKEditorPlugin plugin type.
- Alter existing CKEditor plugin definitions via `hook_ckeditor_plugin_info_alter()`.
- Add iframe CSS to the editor via `hook_ckeditor_css_alter()` or a theme's `ckeditor_stylesheets`.
- Keep the `core/ckeditor` library alias resolving for dependent code.
- Reuse the bundled image and link dialogs at `/cke4-lts/dialog/image/{editor}` and `/cke4-lts/dialog/link/{editor}`.
- Require the `media_embed` filter when the Insert-from-Media-Library button is enabled.
- Configure per-format toolbars validated by the `editor.settings.ckeditor` schema.
- Strip stale disabled-plugin settings from editor config automatically on save.
- Buy time to move editorial workflows from CKEditor 4 to CKEditor 5.
- Run legacy CKEditor 4 builds on a supported Drupal 11 site.
- Bridge a complex editor migration over multiple releases.
