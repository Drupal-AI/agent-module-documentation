# Header Formatter — the `text_header` formatter

Class `Drupal\header_formatter\Plugin\Field\FieldFormatter\TextHeaderFormatter`.

## Applicability
- `field_types = {"string"}` — only core single-line text (`string`) fields.
- `isApplicable()` additionally requires the field **storage cardinality to be exactly 1**. Multi-value
  string fields will not offer this formatter.

## Setting
- `level` (int, default `2`) — heading level. `settingsForm()` renders a select with options H1–H6 (values
  1–6). `settingsSummary()` outputs `"Header level: H{level}"`.

## Output
`viewElements()` returns, per delta:
```php
[
  '#type'  => 'html_tag',
  '#tag'   => "h{$level}",
  '#value' => $item->value,
]
```
So a value `About us` at level 2 renders `<h2>About us</h2>`.

## How to use
Manage display (any entity/bundle/view mode) → for a single-value `string` field choose format **Header** →
click the gear → pick the H-level → *Update* → *Save*. To set it in config, set the display component's
`type` to `text_header` and `settings.level` to the desired 1–6.

## Notes
- `#value` on `html_tag` is passed through core sanitization; the field's own text stays plain (no markup
  interpretation), matching core `string` field behaviour.
- No global settings, permissions, dependencies, or config schema — the `level` value is the only stored
  configuration and lives in the entity view display.
