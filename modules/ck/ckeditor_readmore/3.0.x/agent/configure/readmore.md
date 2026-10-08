# Configure CKEditor Read More

No standalone settings page. Everything is configured per **text format** at
`admin/config/content/formats/manage/<format>`. Two independent pieces must both be turned on.

## 1. Add the toolbar button

Drag the **Read more** button into the CKEditor 5 toolbar. This activates the
`ckeditor_readmore_plugin` (JS plugin `readMore.ReadMore`). A vertical-tab settings section
"Read more" then appears with:

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `type` | radios (`text` / `button`), required | `text` | Render the toggle as plain text or a button. |
| `classes` | textfield | `''` | Extra CSS classes (space-separated) added to the toggle element. |

These persist in the editor's config under `settings.plugins.ckeditor_readmore_plugin`
(schema `ckeditor5.plugin.ckeditor_readmore_plugin`, which also allows a `text_format` key).
Emitted to the JS plugin via `getDynamicPluginConfig()` as `readMore.type` / `readMore.classes`.

## 2. Enable the "Filter readmore" filter

On the same format, enable **Filter readmore** (`filter_readmore`). Without it the toggle
labels and click behavior are not attached on the rendered page. Filter settings
(schema `filter_settings.filter_readmore`):

| Setting | Default | Meaning |
|---|---|---|
| `more_text` | `Read more` | Label written into `data-readmore-more-text` (translatable). |
| `less_text` | `Show less` | Label written into `data-readmore-less-text` (translatable). |

The filter (`TYPE_TRANSFORM_REVERSIBLE`) only acts when the text contains `data-readmore-type`;
it then loads the DOM, sets the two label attributes on each marker `<div>`, and attaches the
`ckeditor_readmore/ckeditor_readmore` library. (That library is also attached site-wide by
`hook_preprocess_html`.)

## 3. Allowed HTML (only if "Limit allowed HTML tags" is on)

The plugin declares these `elements`, so core normally adds them automatically. If missing,
add to the allowed tags:

```
<div class="ckeditor-readmore ckeditor-readmore-wrapper" data-readmore-type data-readmore-more-text data-readmore-less-text data-readmore-classes>
```

## Rendered markup & behavior

Selecting content and clicking Read more wraps it as:

```html
<div class="ckeditor-readmore" data-readmore-type="text" data-readmore-classes="…">…hidden content…</div>
```

`js/ckeditor-readmore.js` (jQuery + `core/once`) reads `data-readmore-type` and the label
attributes and toggles visibility on click.

## CKEditor 4 → 5 upgrade

`src/Plugin/CKEditor4To5Upgrade/ReadMore.php` maps the legacy CKEditor 4 `btn_readmore`
toolbar button to the CKEditor 5 `readMore` item, and the old `readmore` plugin settings
(`type`, `more_text`, `less_text`) into `ckeditor_readmore_plugin` config. v3 no longer
supports CKEditor 4 itself; this only smooths the migration.

## Notes on label handling

`ReadMoreFilter::process()` passes the admin-entered `more_text`/`less_text` through `t()`
before rendering them into attributes. These values are set by a text-format administrator
(`administer filters`, a restricted permission), so they are trusted config; the label text
is emitted as DOM attribute values via `Html::serialize()`.
