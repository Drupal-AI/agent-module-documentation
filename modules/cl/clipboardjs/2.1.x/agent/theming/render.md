<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hooks, render/Form API usage & the library

## Theme hooks (`clipboardjs_theme`)

Four render elements let you add a copy control anywhere (custom forms, blocks, render arrays):

| `#theme` | Twig template |
|---|---|
| `clipboardjs_button` | `clipboardjs-button.html.twig` |
| `clipboardjs_snippet` | `clipboardjs-snippet.html.twig` |
| `clipboardjs_textarea` | `clipboardjs-textarea.html.twig` |
| `clipboardjs_textfield` | `clipboardjs-textfield.html.twig` |

Variables (all optional except `value`): `value` (the text copied), `label`
(default "Click to copy"), `alert_style` (`tooltip`|`alert`|`none`), `alert_text`
(default "Copied!"), `height`, `width` (icon size, default 13), `attributes`. A
`hook_preprocess_HOOK` assigns each element a unique `id` (`uniqid('clipboardjs-')`) and the
module path.

## Use in a render array / Form API

```php
$build['copy'] = [
  '#theme' => 'clipboardjs_button',
  '#value' => 'Any copyable value.',
];

$form['copy'] = [
  '#type' => 'item',
  '#theme' => 'clipboardjs_textfield',
  '#title' => $this->t('Clipboard.js Textfield'),
  '#value' => 'Any copyable value.',
  '#label' => $this->t('Click to copy'),
  '#alert_style' => 'tooltip',      // tooltip | alert | none
  '#alert_text' => $this->t('Copied!'),
];
```

## Libraries

- `clipboardjs/clipboardjs` — the external library (remote v2.0.11), loaded from
  `/libraries/clipboard/dist/clipboard.js`.
- `clipboardjs/drupal` — the module's init JS + base/tooltip CSS (depends on jquery, once,
  drupal, and `clipboardjs/clipboardjs`).
- `clipboardjs/button`, `/snippet`, `/textfield`, `/textarea` — per-style CSS, attached by the
  matching template.

`clipboardjs_library_info_alter()` falls back to the `clipboard.js/dist/clipboard.js`
(Wikimedia composer-merge) path if the default path is absent.

## External dependency (required)

The clipboard.js library is **not** bundled. Download v2.0.11 to
`DRUPAL_ROOT/libraries/clipboard/dist/clipboard.js` (e.g. `composer require npm-asset/clipboard:^2.0.11`
with Asset Packagist). `clipboardjs_requirements()` shows an **error** on
`/admin/reports/status` when the file is missing, a **warning** if only the Wikimedia path is
found, and **OK** otherwise.
