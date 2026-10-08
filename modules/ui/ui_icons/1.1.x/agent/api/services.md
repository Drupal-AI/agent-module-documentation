# API: form element, search, preview, Twig

## `icon_autocomplete` form element

`\Drupal\ui_icons\Element\IconAutocomplete` (`#[FormElement('icon_autocomplete')]`).
A textfield with AJAX autocomplete + live preview. Value is normally an
`IconDefinitionInterface` object (or a `pack_id:icon_id` string with `#return_id`).

```php
$form['icon'] = [
  '#type' => 'icon_autocomplete',
  '#title' => $this->t('Select icon'),
  '#default_value' => 'my_pack:home',        // pack_id:icon_id
  '#allowed_icon_pack' => ['my_pack'],       // [] = all packs
  '#result_format' => 'grid',                // 'list' (default) or 'grid'
  '#max_result' => 20,                       // default IconSearch::SEARCH_RESULT
  '#show_settings' => TRUE,                  // expose extractor settings sub-form
  '#default_settings' => ['size' => 32],
  '#settings_title' => $this->t('Settings'),
  '#return_id' => FALSE,                      // TRUE → submit plain string id
  '#required' => FALSE,
  '#size' => 55,
  '#placeholder' => '',
];
```

Submitted value (default): an object; read id via `$icon->getPackId()` /
`$icon->getId()`, or parse a string id with
`\Drupal\Core\Theme\Icon\IconDefinition::getIconDataFromId($id)` →
`['pack_id' => ..., 'icon_id' => ...]`.

## `ui_icons.search` service — `\Drupal\ui_icons\IconSearch`

```php
$icons = \Drupal::service('ui_icons.search')->search(
  $query,             // string, matches icon id/label
  $allowed_icon_pack, // array of pack_ids, [] = all
  $max_result,        // int
  $result_callback,   // optional callable(IconDefinitionInterface): mixed
);
```
Constant `IconSearch::SEARCH_RESULT` is the default result cap. Results are cached
(`cache.default`).

## Preview

- `\Drupal\ui_icons\IconPreview::getPreview(IconDefinitionInterface $icon, array $settings = []): array`
  returns a render array for one icon.
- Twig function (registered by `ui_icons.twig_extension`):
  `{{ icon_preview(pack_id, icon_id, settings) }}` — settings is an optional array.
- Route `ui_icons.preview` (`POST /ui-icons/ajax/preview/icons`) backs the live
  preview in the autocomplete element.

## Rendering an icon directly

Use core's Icon render element (provided by core, not this module):
```php
$build['icon'] = ['#type' => 'icon', '#pack_id' => 'my_pack', '#icon_id' => 'home', '#settings' => ['size' => 32]];
```
