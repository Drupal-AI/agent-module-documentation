# CKEditor line-break conversion (configure)

There is **no module settings page**. The only configuration is a single radio, injected by the module
into the CKEditor plugin settings of a text format, on the *Text formats and editors* page
(`admin/config/content/formats/manage/<format>`, gated by core `administer filters`). Configure a format
whose text editor is **CKEditor 5**; a **Conversion Method** section appears below the toolbar config.

## The setting

- CKEditor 5 plugin definition: `wysiwyg_linebreaks.ckeditor5.yml` → `wysiwyg_linebreaks_extension`
  (JS plugin `linebreaks.LineBreaks`, library `wysiwyg_linebreaks/ckeditor5`, elements `<p>`, `<br>`).
- Drupal plugin class: `Plugin\CKEditor5Plugin\LineBreaks` (`CKEditor5PluginConfigurableInterface`).
  `buildConfigurationForm()` (LineBreaks.php:44) exposes one radio; `submitConfigurationForm()` stores it.
- Config schema: `ckeditor5.plugin.wysiwyg_linebreaks_extension`.

| Key | Type | Values | Default | Meaning |
|---|---|---|---|---|
| `method` | string (enum) | `force`, `convert` | `force` | How line breaks are handled at the editor boundary. |

`getDynamicPluginConfig()` (LineBreaks.php:24) hands the JS `{ linebreaks: { method: <method> } }`, which
the client plugin reads via `editor.config.get('linebreaks').method`.

## What each method does (client-side, in the browser)

Both modes convert **on open**; only `force` converts back **on save**. Logic lives in
`LineBreaksFilter` (`js/ckeditor5_plugins/linebreaks/src/linebreaksfilter.js`, built to
`js/build/linebreaks.js`):

- **Open (always):** on the editor `ready` event, `attach()` reads the source textarea's raw `value`,
  runs `linebreaks_attach()` (newlines → `<p>` / `<br>`, protecting `<pre>`/`<script>`/`<object>`/`<embed>`
  and known block elements), and calls `editor.setData()`. This is why legacy plain text shows as
  paragraphs in the editor.
- **Save (`force` only):** on the editor `destroy` event, `detach()` runs `linebreaks_detach()`
  (`<p>`/`<br>` → newlines, block elements spaced with newlines) and writes the cleaned plain text back
  into the textarea. The stored value therefore stays plain text — pair the format with a display filter
  such as core's "Convert line breaks into HTML" (`filter_autop`) so it renders correctly.
- **Save (`convert`):** no destroy handler is registered; the editor's HTML (`<p>`/`<br>`) is saved as-is.

## Set the method from code / config

The value is stored inside the editor entity's CKEditor 5 plugin settings, not in a module config object:

```php
$editor = \Drupal\editor\Entity\Editor::load('basic_html'); // = the text format id
$settings = $editor->getSettings();
$settings['plugins']['wysiwyg_linebreaks_extension']['method'] = 'convert'; // or 'force'
$editor->setSettings($settings);
$editor->save();
```

## Legacy CKEditor 4 and the upgrade path

- Legacy CKEditor 4 plugin `Plugin\CKEditorPlugin\Linebreaks` (id `linebreaks`) serves
  `js/plugins/linebreaks/linebreaks.js` and reads config key `linebreaks_method` (default `force`); its
  `settingsForm()` shows the same force/convert radio. `isEnabled()` returns `TRUE` whenever the module
  is on.
- `Plugin\CKEditor4To5Upgrade\LineBreaks` (`@CKEditor4To5Upgrade(id="linebreaks")`) maps a saved CKE4
  `linebreaks` plugin setting onto the CKE5 `LineBreaks` configuration when a format is migrated to
  CKEditor 5.
