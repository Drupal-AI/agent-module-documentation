<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render a string/text field as a heading (`heading_text` formatter)

Besides the `heading` field type, the module adds a **formatter for existing core fields** so
you can output a plain `string` or `text` field wrapped in a heading element — no new field
needed.

## Formatter `heading_text` (`TextFormatter`)

- `@FieldFormatter(id = "heading_text", field_types = {"string", "text"})`.
- Single setting **`size`** — the heading level; default `h2`
  (`defaultSettings()` → `['size' => 'h2']`). Options are `h1`–`h6`.
- `settingsSummary()` shows e.g. "Heading (H2)".
- Output: each non-empty item is wrapped in an `html_tag` of that size:
  - `text` fields → child rendered as `processed_text` (respects the text format).
  - `string` fields → child rendered via inline template `{{ value|nl2br }}`.
- Empty values are skipped.

## Via the UI

1. Go to the entity's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. On a **string** or **text** field's row, choose format **Heading**.
3. Click the cog, pick the **Size** (h1–h6), *Update*, *Save*.

## Where it is stored (config)

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  field_subtitle:
    type: heading_text
    label: hidden
    settings:
      size: h3
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_subtitle`.

## Scriptable (drush php:eval)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_subtitle', [
  'type' => 'heading_text',
  'settings' => ['size' => 'h3'],
  'label' => 'hidden', 'region' => 'content', 'weight' => 5,
])->save();
```
