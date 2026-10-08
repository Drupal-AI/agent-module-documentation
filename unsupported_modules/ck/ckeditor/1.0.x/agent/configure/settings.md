<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure CKEditor 4 - LTS

Two layers: (1) the module's own **LTS license-key** settings form, and (2) the normal **per-text-format
editor + toolbar** config (identical to core CKEditor 4).

## LTS license key (module-specific)

Form: **Configuration → Content authoring → CKEditor4 - LTS**
(`/admin/config/ckeditor-lts/settings`, route `ckeditor.lts.settings`, form
`Drupal\ckeditor\Form\SettingsForm`, permission `administer site configuration`).

```yaml
# ckeditor.lts.settings   (schema: ckeditor.lts.settings)
license_key: '<your Extended Support Model key>'   # optional; if set, min 48 chars (validated)
```

- Read at runtime by `Config\SettingsConfigHandler::getLicenseKey()` and injected into CKEditor's JS
  config as `licenseKey` (`Plugin\Editor\CKEditor::getJSSettings()`).
- On save the form invalidates cache tags `ckeditor_plugins`, `editor_plugins`, `filter_plugins`.
- Set via Drush: `drush cset ckeditor.lts.settings license_key '<key>' -y`.
- **Advanced → Clear cache** button calls `apcu_clear_cache()` / `wincache_ucache_clear()` — needed
  when this module replaces a previously-installed OSS `ckeditor` so the new library/plugins load. See
  the module README for the `rebuild_token_calculator.sh` + `/rebuild.php` route if you lack CLI APCu.

## Per-format editor & toolbar (core editor config)

Assign CKEditor to a text format at **Configuration → Content authoring → Text formats and editors**
(`admin/config/content/formats`) → choose **CKEditor** as the *Text editor*. This stores the editor on
the core `editor` config entity; the CKEditor-specific part lives under `settings` with schema
`editor.settings.ckeditor`:

```yaml
# editor.editor.<format_id>
editor: ckeditor
settings:
  toolbar:
    rows:                      # toolbar builder output
      - - name: 'Formatting'
          items: ['Bold', 'Italic', 'DrupalLink', 'DrupalUnlink']
  plugins:
    language:
      language_list: 'un'      # schema ckeditor.plugin.language
    stylescombo:
      styles: "h1.title|Title\np.mytext|My text"   # schema ckeditor.plugin.stylescombo
```

- `toolbar.rows` is a list of rows, each a list of button groups (`name` + `items`). Buttons come from
  the enabled `@CKEditorPlugin`s (a plugin is enabled when one of its buttons is placed in the toolbar,
  or when it declares itself contextually enabled).
- `plugins.<id>` holds per-plugin settings for plugins implementing `CKEditorPluginConfigurableInterface`
  (shipped: `language`, `stylescombo`).

## Editor plugin definition

`Plugin\Editor\CKEditor` — `@Editor(id="ckeditor", supports_content_filtering=TRUE,
supports_inline_editing=TRUE, is_xss_safe=FALSE, supported_element_types={"textarea"})`. Because
`is_xss_safe=FALSE`, output is still sanitized by the format's filters — keep a proper HTML-restricting
filter enabled on any CKEditor format (this is normal core behavior, not a module flaw).

## Image / link dialogs

Routes `/cke4-lts/dialog/image/{editor}` and `/cke4-lts/dialog/link/{editor}` (forms
`EditorImageDialog`, `EditorLinkDialog`) back the `drupalimage`/`drupallink` buttons. Both require
`_entity_access: editor.use` on the target editor, so only users who can use that format's editor can
open them.

## Library

`ckeditor.libraries.yml` defines `ckeditor/ckeditor` → vendored `vendor/ckeditor.js` version
`4.25.1-lts` (plus admin/plugin sub-libraries). This module overrides any OSS CKEditor 4 build present.
