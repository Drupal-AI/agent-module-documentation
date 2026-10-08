<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Formatters — API & the settings contract

The module's `custom_formatters.api.php` documents the **per-instance settings** contract rather than
classic `hook_*` alter hooks. (There is a `@todo` for a formatter-type alter hook in
`FormatterTypeManager`, but none is invoked in this release.)

## The `$settings` array passed to engines

A `formatter` config entity is the bundle of the `formatter_setting` content entity. Fields added to a
formatter (via its Manage fields / Manage form display tabs) render as an inline entity form when the
formatter is selected on *Manage display*, and their saved values reach the engine keyed by field
machine name in two forms:

```php
$settings = [
  // Rendered through the field's view display formatter.
  'field_css_class'  => '<span>featured</span>',
  'field_show_label' => 'Yes',
  // Unformatted getString() values.
  '_raw' => [
    'field_css_class'  => 'featured',
    'field_show_label' => '1',
  ],
];
```

Access per engine:

| Engine | Rendered value | Raw value |
|---|---|---|
| PHP | `$settings['field_css_class']` | `$raw_settings['field_css_class']` (PHP extracts `_raw` into `$raw_settings`) |
| Twig | `{{ settings.field_css_class }}` | `{{ raw_settings.field_css_class }}` |
| HTML+Token | `[formatter_setting:field_css_class]` | `[formatter_setting:field_css_class:raw]` |

## Engine entry point

Every engine implements `viewElements(FieldItemListInterface $items, $langcode, array $settings = [])`
and returns a render array or `['#markup' => …]`. The stored `data` blob is read from
`$this->entity->get('data')`. To add your own engine, see
[../plugins/formatter-types.md](../plugins/formatter-types.md).

## Integrations (optional includes)

`modules/insert.inc` and `modules/codemirror_editor.inc` add integration behavior when the `insert` /
`codemirror_editor` contrib modules are present (Insert styles for image/file/reference formatters;
syntax highlighting + autocomplete on the code fields). `token` / `field_tokens` power the HTML+Token
engine's token tree; `devel` enables preview debug output and Devel Generate sample content
(`DevelGenerateIntegration`). These are suggestions, not dependencies.
