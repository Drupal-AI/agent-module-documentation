<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# prismjs — configuration, CKEditor flow & routes

## Settings form
`\Drupal\prismjs\Form\PrismJsSettingsForm` (`src/Form/PrismJsSettingsForm.php`), form id
`prismjs_settings_form`, route `prismjs.settings` at `/admin/config/content/prism-js`. Edits config
object **`prismjs.settings`**.

Two settings:
- **`languages`** — a `checkboxes` element over `prismjs_available_languages()` (in `prismjs.module`,
  ~297 Prism grammars). `#required`. Default when unset: `['c', 'css', 'java', 'javascript',
  'markup', 'php']`. Controls only which languages appear in the CKEditor dialog's `<select>`.
- **`theme`** — a `select` of eight bundled themes: `default`, `dark`, `funky`, `okaidia`,
  `twilight`, `coy`, `solarized-light`, `tomorrow-night`. `#required`. Chooses the `prismjs/prismjs.{theme}`
  library the filter attaches. (Form default value string is `prism-tomorrow`, but the filter falls
  back to `tomorrow-night` when the stored value is empty.)

Permission: **`administer prismjs configuration`** (`prismjs.permissions.yml`, `restrict access:
TRUE`). This is the only permission the module defines; there is no separate "insert code" permission
— any user of a text format that has CKEditor 5 + the Prism Js button can insert blocks.

Config schema is provided (`provides_config_schema: true`) for `prismjs.settings`.

## CKEditor 5 integration flow
1. `prismjs.info.yml` declares the CKEditor 5 plugin via `prismjs.ckeditor5.yml`; the toolbar button
   is `prismJs`.
2. `Drupal\prismjs\Plugin\CKEditor5Plugin\PrismJs::getDynamicPluginConfig()` injects two URLs into the
   editor config: `prismJs.dialogURL` (route `prismjs.dialog`) and `prismJs.previewURL` (route
   `prismjs.preview`, with the editor id).
3. `js/build/prismJs.js` registers a `prismJs` model element, downcast to a `<prism-js>` view element
   with `data-plugin-id` / `data-plugin-config` attributes, and opens the dialog on button click.
4. **Dialog** `\Drupal\prismjs\Form\PrismJsDialogForm` (route `prismjs.dialog`, `_access: TRUE` —
   reachable without a specific permission): renders a language `<select>` (options = the intersection
   of configured `languages` and `prismjs_available_languages()`) plus the `language_select` plugin's
   "Source Code" textarea. `ajaxSubmitForm()` returns an `EditorDialogSave` command whose attributes
   are `data-plugin-id` and `data-plugin-config = Json::encode($plugin_config)` (where
   `$plugin_config` = `{text, language}`). The dialog **stores nothing server-side** — it only hands
   markup back to the editor. Incoming `plugin_config` from the request is run through `Xss::filter`
   before `Json::decode`.
5. **Preview** `\Drupal\prismjs\Controller\PrismJsPreview::preview` (route `prismjs.preview`): access
   callback `checkAccess` = `AccessResult::allowedIfHasPermission($account, 'use text format ' .
   $editor->getFilterFormat()->id())`. Runs `Xss::filter` on `plugin_id`/`plugin_config`, decodes the
   JSON, instantiates the `language_select` plugin, and returns the rendered `build()` for the
   in-editor preview. The `language_select` build attaches `prismjs/prismjs.tomorrow-night` and themes
   via the `prismjs_language_select` template (Twig-autoescaped).

## Routes summary
| Route | Path | Access |
|-------|------|--------|
| `prismjs.settings` | `/admin/config/content/prism-js` | `administer prismjs configuration` |
| `prismjs.dialog` | `/prism-js/dialog/{uuid}` | `_access: 'TRUE'` (open) |
| `prismjs.preview` | `/prism-js/preview/{editor}` | `use text format {format}` |

Menu link: `prismjs.links.menu.yml`. Services: `prismjs.services.yml` defines the
`plugin.manager.ckedito5_prismjs` manager.

## Enabling on a text format (from README)
1. Enable CKEditor 5 on the format.
2. Drag the **Prism Js** button onto the active toolbar.
3. Enable the **"Prism Js"** filter on the same format.
4. Unless the format is **Full HTML**, allow `<pre>`, `<code>`, and the `class` attribute in the
   "Limit allowed HTML tags" filter (and the `<prism-js>` element must survive to reach the filter).
5. Flush caches after changing settings for them to take effect.
