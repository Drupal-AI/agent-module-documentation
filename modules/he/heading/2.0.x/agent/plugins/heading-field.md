<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `heading` field type, widget & formatter

## Field type `heading` (`HeadingItem`)

- `@FieldType(id = "heading", default_widget = "heading", default_formatter = "heading", category = "plain_text")`.
- **Storage columns** (`schema()`):
  - `text` — varchar 255 (the heading text).
  - `size` — char 2 (the level, e.g. `h2`).
- `isEmpty()` is true only when both `size` and `text` are empty.
- **Field settings** (`defaultFieldSettings()` / `fieldSettingsForm()`):
  - `label` — the form label shown above the text input (default `'Heading'`).
  - `allowed_sizes` — array of allowed levels; default `['h1','h2','h3','h4','h5','h6']`.
    Presented as checkboxes; limit it to constrain which levels editors may pick.

Create it in code:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_section_heading', 'entity_type' => 'node', 'type' => 'heading',
])->save();
FieldConfig::create([
  'field_name' => 'field_section_heading', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Section heading',
  'settings' => ['label' => 'Title', 'allowed_sizes' => ['h2', 'h3']],
])->save();
```

Read allowed sizes back: `$fieldConfig->getSetting('allowed_sizes')` or
`drush cget field.field.node.article.field_section_heading settings.allowed_sizes`.

## Widget `heading` (`HeadingWidget`)

- `@FieldWidget(id = "heading", field_types = {"heading"})`.
- Renders a **textfield** (`text`, maxlength 255) plus a size **`<select>`** (`size`).
- If `allowed_sizes` resolves to exactly one size, the select is replaced by a fixed
  `#type => 'value'` (hidden) so the single size is applied automatically.
- Attaches library `heading/widget`.

## Formatter `heading` (`HeadingFormatter`)

- `@FieldFormatter(id = "heading", field_types = {"heading"})`.
- For each non-empty item renders `['#theme' => 'heading', '#size' => $item->size, '#text' => $item->text]`.
- The `heading` theme hook uses `templates/heading.html.twig`:
  `<{{ size }}>{{ text }}</{{ size }}>` (variables `size`, `text`). Override it in a theme to
  change heading markup.
- Empty text is skipped (no empty heading rendered).

## Tokens

`hook_token_info_alter()` (in `HeadingHooks`) advertises, for every heading field, tokens
`[<entity>-<field>:size]` and `[<entity>-<field>:text]`.

## Config schema

`field.field_settings.heading` (`label`, `allowed_sizes` sequence), `field.value.heading`
(`text`, `size`), plus empty mappings for storage/widget/formatter settings.
