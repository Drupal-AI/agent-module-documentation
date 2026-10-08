<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ui_styles_attributes` UI Patterns source

## What it is

A UI Patterns **Source** plugin (`Drupal\ui_styles_ui_patterns\Plugin\UiPatterns\Source\AttributesStyles`):

```php
#[Source(
  id: 'ui_styles_attributes',
  label: new TranslatableMarkup('Styles attributes'),
  description: new TranslatableMarkup('Handle CSS classes with UI Styles.'),
  prop_types: ['attributes'],
)]
```

It is discovered by `plugin.manager.ui_patterns_source` and offered anywhere a UI Patterns
component prop of type **`attributes`** is being configured (component slots/props in blocks,
field formatters, Layout Builder, views, etc.). No standalone route or permission.

## Settings form

`settingsForm()` embeds two controls:
- **`styles`** — the standard `#type => 'ui_styles_styles'` selector (grouped style options).
- **`extra`** — an "Extra HTML attributes" textfield ("HTML attributes with double-quoted
  values").

## Config shape

Stored wherever the component's source config lives, under this schema
(`ui_patterns_source.ui_styles_attributes`):

```yaml
styles:                       # a ui_styles.selected_mapping
  selected:
    text_color: text-primary
  extra: 'p-3'
extra: 'data-foo="bar"'       # extra raw HTML attributes string
```

## How classes reach the prop

`getPropValue()` returns an attributes **mapping**:
1. Parse `extra` (raw HTML attributes) into a base mapping.
2. Read `styles.selected` (values = classes) and `styles.extra` (space-split classes).
3. Merge them, de-duplicate, and set `mapping['class'] = [ ...classes ]`.

The component then renders those attributes (including the `class` list) on the prop's target
element. `UiStylesUtility::extractSelectedStyles()` is used to read the older
`_ui_styles_extra` config structure for backward compatibility.

## Verify the source is registered

```bash
drush ev 'var_dump(\Drupal::service("plugin.manager.ui_patterns_source")->hasDefinition("ui_styles_attributes"));'
```
