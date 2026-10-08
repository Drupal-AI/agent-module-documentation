<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 4 - LTS (ckeditor_lts) — agent index

Re-publishes the **CKEditor 4** text editor that Drupal core removed in favour of CKEditor 5.
Registers the `ckeditor` Editor plugin (`@Editor(id="ckeditor")`) and bundles the CKEditor 4
JS build (`vendor/ckeditor.js`, library version `4.25.1-lts`), so existing CKEditor 4 text
formats, toolbars and custom `Plugin/CKEditorPlugin` plugins keep working on Drupal 9.4–11.
The module's machine name is **`ckeditor`** — it stands in for the removed core module of that
name; the drupal.org project is `ckeditor_lts`. Version **1.0.5**, core `^9.4 || ^10 || ^11`.

- Depends only on core `editor`. No composer requirements, no submodules.
- Settings page: route `ckeditor.lts.settings` → `/admin/config/ckeditor-lts/settings`
  (permission `administer site configuration`). Stores the CKEditor 4 LTS license key.
- Defines a plugin type (`@CKEditorPlugin`); no permissions, no drush; provides config schema.

## Solution docs
- **Set the LTS license key / clear cache after a swap** → [configure/settings.md](configure/settings.md)
- **Add a custom CKEditor 4 button or plugin** → [plugins/ckeditor-plugins.md](plugins/ckeditor-plugins.md)
- **Integrate: read the key, alter plugins/CSS, editor id, libraries, dialog routes** → [api/integration.md](api/integration.md)

## Key facts
- Editor plugin id: `ckeditor` (class `Drupal\ckeditor\Plugin\Editor\CKEditor`, label "CKEditor", `textarea`)
- Settings route: `ckeditor.lts.settings`; menu link id `ckeditor.lts.form.settings` (under `system.admin_config_content`)
- Dialog routes: `ckeditor.lts.image_dialog` (`/cke4-lts/dialog/image/{editor}`) and
  `ckeditor.lts.link_dialog` (`/cke4-lts/dialog/link/{editor}`), both `_entity_access: editor.use`
- Config object: `ckeditor.lts.settings`, single key `license_key` (string, min 48 chars if set)
- Per-text-format editor schema: `editor.settings.ckeditor` (toolbar rows + plugins)
- Plugin type: annotation `@CKEditorPlugin` (`Drupal\ckeditor\Annotation\CKEditorPlugin`),
  manager `plugin.manager.ckeditor.plugin`, namespace `Plugin/CKEditorPlugin`,
  interface `Drupal\ckeditor\CKEditorPluginInterface`, base `Drupal\ckeditor\CKEditorPluginBase`
- Service: `ckeditor.lts.config_handler.settings` → `SettingsConfigHandlerInterface::getLicenseKey(): ?string`
- Libraries: `ckeditor/ckeditor` (bundled CKEditor 4 build), `ckeditor/drupal.ckeditor` plus admin libraries;
  a `core/ckeditor` alias is re-created via `hook_library_info_alter()` so code depending on it still resolves
- Invoked hooks for integrators: `hook_ckeditor_plugin_info_alter()`, `hook_ckeditor_css_alter()`
