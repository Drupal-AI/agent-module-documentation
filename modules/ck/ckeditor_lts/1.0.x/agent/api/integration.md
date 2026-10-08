# Integration: editor plugin, service, hooks, libraries, routes

## Editor plugin

`Drupal\ckeditor\Plugin\Editor\CKEditor` registers `@Editor(id="ckeditor", label="CKEditor")`,
`supports_content_filtering = TRUE`, `supports_inline_editing = TRUE`, element type `textarea`.
This is the same plugin id the removed core module used, so existing `editor` config entities
with `"editor": "ckeditor"` bind to it unchanged.

`getJSSettings(Editor $editor)` assembles the CKEditor 4 client config: it merges every enabled
plugin's `getConfig()`, then sets `toolbar`, `contentsCss`, `extraPlugins`, `language`,
`stylesSet` (FALSE), `drupalExternalPlugins`, and `licenseKey` (from the settings service below).

## Public service: license-key handler

| | |
|---|---|
| Service id | `ckeditor.lts.config_handler.settings` |
| Class | `Drupal\ckeditor\Config\SettingsConfigHandler` |
| Interface | `Drupal\ckeditor\Config\SettingsConfigHandlerInterface` |
| Method | `getLicenseKey(): ?string` — returns `ckeditor.lts.settings:license_key`, or `NULL` |

```php
$key = \Drupal::service('ckeditor.lts.config_handler.settings')->getLicenseKey();
```

## Hooks the module INVOKES (for integrators)

Documented in `ckeditor.api.php`:

- `hook_ckeditor_plugin_info_alter(array &$plugins)` — modify CKEditor plugin definitions after
  discovery (e.g. relabel a plugin). Alter id `ckeditor_plugin_info`.
- `hook_ckeditor_css_alter(array &$css, \Drupal\editor\Entity\Editor $editor)` — add iframe CSS
  files without providing a plugin.

Themes may also add iframe CSS via a `ckeditor_stylesheets:` list in their `.info.yml`
(resolved by `_ckeditor_theme_css()`, which also walks base themes).

Theme hook: `ckeditor_settings_toolbar` (template `templates/ckeditor-settings-toolbar.html.twig`,
preprocess in `ckeditor.admin.inc`) — the drag-and-drop toolbar builder on the format edit form.

## Hooks the module IMPLEMENTS that affect integrators

- `hook_library_info_alter()` — passes Drupal's `system.css_js_query_string` into
  `drupal.ckeditor` as `drupalSettings.ckeditor.timestamp`, and **re-creates a `core/ckeditor`
  library alias** (depending on `ckeditor/ckeditor`) when core does not define one, so code that
  still declares a dependency on `core/ckeditor` keeps resolving.
- `hook_ckeditor_css_alter()` (own impl) — adds `filter/css/filter.caption.css` when the
  format uses the `filter_caption` filter (for the DrupalImageCaption plugin).
- `hook_ENTITY_TYPE_presave()` = `ckeditor_editor_presave()` — strips stored `settings.plugins`
  entries for plugins that are no longer enabled on a `ckeditor` editor.
- `hook_form_FORM_ID_alter()` on `filter_format_add_form` / `filter_format_edit_form` — adds a
  validate handler requiring the `media_embed` filter when the `DrupalMediaLibrary` button is used.
- `hook_theme()`, `hook_help()` (help route `help.page.ckeditor`).

Post-update: `ckeditor_post_update_omit_settings_for_disabled_plugins()` cleans legacy editor
config the same way as the presave hook.

## Libraries (`ckeditor.libraries.yml`)

- `ckeditor/ckeditor` — the bundled CKEditor 4 build, `vendor/ckeditor.js`
  (`version: "4.25.1-lts"`, remote `github.com/ckeditor/ckeditor4`).
- `ckeditor/drupal.ckeditor` — Drupal's editor glue (`js/ckeditor.js` + CSS), depends on
  `ckeditor/ckeditor` and `editor/drupal.editor`.
- Admin/plugin libraries: `drupal.ckeditor.admin`, `drupal.ckeditor.drupalimage.admin`,
  `drupal.ckeditor.stylescombo.admin`, `drupal.ckeditor.language.admin`,
  `drupal.ckeditor.plugins.drupalimagecaption`, `drupal.ckeditor.plugins.language`,
  `drupal.ckeditor.plugins.drupalmedia`.

## Routes

| Route | Path | Access |
|-------|------|--------|
| `ckeditor.lts.settings` | `/admin/config/ckeditor-lts/settings` | `_permission: administer site configuration` |
| `ckeditor.lts.image_dialog` | `/cke4-lts/dialog/image/{editor}` | `_entity_access: editor.use` (`Drupal\ckeditor\Form\EditorImageDialog`) |
| `ckeditor.lts.link_dialog` | `/cke4-lts/dialog/link/{editor}` | `_entity_access: editor.use` (`Drupal\ckeditor\Form\EditorLinkDialog`) |
