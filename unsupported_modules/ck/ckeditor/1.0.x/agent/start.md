<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 4 - LTS — agent index

Composer project `ckeditor_lts`, **machine name `ckeditor`**. The old core CKEditor 4 module revived
as contrib, bundling the CKEditor 4.25.1-lts build plus an LTS license-key field. Provides a `ckeditor`
text-editor plugin for core `editor`, a `CKEditorPlugin` plugin type, and the Drupal integration
plugins. Depends on core `editor`. No permissions.yml of its own, no Drush.

- **LTS license key, the settings form, per-format editor/toolbar config, config storage, cache clear** →
  [configure/settings.md](configure/settings.md)
- **Implement a `@CKEditorPlugin` (interfaces, base class, buttons/config/CSS/contextual)** →
  [plugins/ckeditor-plugin.md](plugins/ckeditor-plugin.md)
- **Alter hooks: `hook_ckeditor_plugin_info_alter`, `hook_ckeditor_css_alter`** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Editor plugin `ckeditor` (`Plugin\Editor\CKEditor`, `@Editor`, `is_xss_safe = FALSE`,
  `supported_element_types = {textarea}`). Attach via a text format's editor.
- LTS settings: route `ckeditor.lts.settings` → `/admin/config/ckeditor-lts/settings` (perm
  `administer site configuration`). Config `ckeditor.lts.settings:license_key` (min 48 chars) → passed
  to CKEditor as `licenseKey` in `CKEditor::getJSSettings()`.
- Editor/toolbar config stored in the core `editor` config entity under `editor.settings.ckeditor`
  (schema `config/schema/ckeditor.schema.yml`: `toolbar.rows`, `plugins`).
- Plugin type: manager `plugin.manager.ckeditor.plugin`, dir `Plugin/CKEditorPlugin`, annotation
  `@CKEditorPlugin`, base `CKEditorPluginBase`, interfaces `CKEditorPlugin{Buttons,Contextual,
  Configurable,Css}Interface`, alter `hook_ckeditor_plugin_info`.
- Shipped plugins: `drupalimage`, `drupalimagecaption`, `drupallink`, `drupalmedia`,
  `drupalmedialibrary`, `language`, `stylescombo`, `internal`.
- Dialog routes `/cke4-lts/dialog/image|link/{editor}` (`_entity_access: editor.use`).
- Library `ckeditor/ckeditor` = vendored build 4.25.1-lts (`vendor/ckeditor.js`).
- CAUTION: CKEditor 4 is EOL (June 2023). LTS build has commercial security patches but needs a paid
  license; use as a bridge to CKEditor 5, not for new sites. (No security.md — no code-level finding.)
