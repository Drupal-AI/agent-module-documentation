<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ui_styles_attributes` UI Patterns source

Enable with `drush en ui_styles_ui_patterns` (needs `ui_patterns` 2.x + `ui_styles`).

## Plugin

`Drupal\ui_styles_ui_patterns\Plugin\UiPatterns\Source\AttributesStyles` extends
`Drupal\ui_patterns\SourcePluginBase` and uses `AttributesTrait`:

```php
#[Source(
  id: 'ui_styles_attributes',
  label: new TranslatableMarkup('Styles attributes'),
  description: new TranslatableMarkup('Handle CSS classes with UI Styles.'),
  prop_types: ['attributes']
)]
```

Because `prop_types` is `['attributes']`, it is offered as a source anywhere a UI Patterns
component exposes an `attributes` prop (component wrapper attributes, a slot's attributes, …),
in whatever context the component is configured (block, field formatter, Layout Builder).

## Settings form

`settingsForm()` adds:

- `styles` → a `ui_styles_styles` element (`#wrapper_type => 'container'`, `#tree`), holding
  `{selected, extra}`.
- `extra` → a textfield "Extra HTML attributes" (e.g. `title="Lorem ipsum" id="my-id"`).

Config schema `ui_patterns_source.ui_styles_attributes`:

```yaml
styles: ui_styles.selected_mapping   # {selected, extra}
extra:  string                       # extra HTML attributes
```

## Producing the prop value

`getPropValue()` returns an attributes mapping:

1. If a legacy string `value` setting is present, it is parsed to an attributes mapping.
2. Otherwise it parses the `extra` HTML-attributes string, then reads `styles`:
   - new shape → `selected` + `extra` from `styles`;
   - old shape (`_ui_styles_extra` present) → `UiStylesUtility::extractSelectedStyles($styles)`
     for `selected` and `$styles['_ui_styles_extra']` for extra (back-compat, to be removed in
     UI Styles 2).
3. Selected option classes + space-split extra classes are merged
   (`array_unique`/`array_filter`) into `$mapping['class']` (a values array).

`settingsSummary()` shows each chosen style as `Label: Option` (or just the label when a
single-option style names itself). No route or permission of its own.
