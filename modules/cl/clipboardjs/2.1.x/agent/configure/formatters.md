<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatters

The module has **no admin settings page** (`configure: null`). You use it by choosing a
Clipboard.js formatter on an entity bundle's **Manage display** page (or in a View's field
settings).

## The four formatters

| Formatter id | Label | Template |
|---|---|---|
| `clipboard_button` | Clipboard.js Button | `clipboardjs_button` |
| `clipboard_snippet` | Clipboard.js Snippet | `clipboardjs_snippet` |
| `clipboard_textfield` | Clipboard.js Textfield | `clipboardjs_textfield` |
| `clipboard_textarea` | Clipboard.js Textarea | `clipboardjs_textarea` |

All extend `ClipboardJsBase` and apply to these field types:
`string`, `email`, `link`, `integer`, `decimal`, `float`, `slug`, `slug_path`. For a `link`
field the copied value is the URL; for `email`/text the raw value.

## Settings (schema `field.formatter.settings.clipboard*`)

| Key | Default | Meaning |
|---|---|---|
| `label` | `Click to copy` | button / hovertip text |
| `alert_style` | `tooltip` | one of `tooltip`, `alert`, `none` |
| `alert_text` | `Copied!` | confirmation shown after copying |

## Set a formatter in code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_code', [
    'type' => 'clipboard_button',
    'settings' => ['label' => 'Copy code', 'alert_style' => 'tooltip', 'alert_text' => 'Copied!'],
  ])
  ->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_code
# look for type: clipboard_button and its settings.label / alert_style / alert_text
```
