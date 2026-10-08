# API: form element, search, preview, Twig

## `icon_autocomplete` form element

`\Drupal\ui_icons\Element\IconAutocomplete` (`#[FormElement('icon_autocomplete')]`,
extends `FormElementBase`). A `search`-type textfield with AJAX autocomplete + live preview.

```php
$form['icon'] = [
  '#type' => 'icon_autocomplete',
  '#title' => $this->t('Select icon'),
  '#default_value' => 'my_pack:home',        // pack_id:icon_id string
  '#allowed_icon_pack' => ['my_pack'],       // [] = all packs
  '#result_format' => 'grid',                // 'grid' or anything else = list (default 'list')
  '#max_result' => 20,                       // default IconSearch::SEARCH_RESULT (24)
  '#show_settings' => TRUE,                  // expose extractor settings sub-form
  '#default_settings' => ['my_pack' => ['size' => 32]], // keyed by pack id
  '#settings_title' => $this->t('Settings'),
  '#return_id' => FALSE,                      // TRUE → submit id string instead of object
  '#required' => FALSE,
  '#size' => 55,                              // default 55
  '#placeholder' => '',
];
```

### Submitted value shape (changed in 2.0)

The element returns an **array**, not a bare object:
- default (`#return_id` FALSE): `['icon' => IconDefinitionInterface, 'settings' => [pack_id => [...]]]`
- with `#return_id` TRUE: `['target_id' => 'pack_id:icon_id', 'settings' => [pack_id => [...]]]`

Empty submission resolves to `NULL` (when not `#required`). Read the object id via
`$value['icon']->getPackId()` / `->getId()`, or parse a string id with
`\Drupal\Core\Theme\Icon\IconDefinition::getIconDataFromId($id)`. Extractor settings are
**always keyed by pack id** — flattening them empties the settings sub-form.

## `ui_icons.search` service — `\Drupal\ui_icons\IconSearch`

```php
$icons = \Drupal::service('ui_icons.search')->search(
  $query,             // string; min length IconSearch::SEARCH_MIN_LENGTH (2)
  $allowed_icon_pack, // array of pack_ids, [] = all
  $max_result,        // int, default IconSearch::SEARCH_RESULT (24)
  $result_callback,   // optional callable(IconDefinitionInterface $icon, Markup $rendered): mixed
);
```
Constants: `SEARCH_MIN_LENGTH=2`, `SEARCH_RESULT=24`, `SEARCH_RESULT_MAX=132`,
`ICON_PREVIEW_SIZE=32`. Returns icon full-id strings (or callback output). Fuzzy, priority
ordered (words in order → any order → any parts). Results are cached in `cache.default`
(tags `icon_pack_plugin`, `icon_pack_collector`).

## Preview

- `\Drupal\ui_icons\IconPreview::getPreview(IconDefinitionInterface $icon, array $settings = []): array`
  (static) returns a render array for one icon; uses the pack's `preview:` template if set,
  else the `icon_preview` theme hook. Default size 48 (`size` in `$settings` overrides).
- Twig function (registered by `ui_icons.twig_extension`):
  `{{ icon_preview(pack_id, icon_id, settings) }}` — settings optional (defaults `{size:32}`).
- Route `ui_icons.preview` (`POST /ui-icons/ajax/preview/icons`) backs the live preview;
  body is JSON `{"icon_full_ids": [...], "settings": {...}}`, returns `{icon_full_id: markup}`.

## Rendering an icon directly

Use core's Icon render element (provided by core, not this module):
```php
$build['icon'] = ['#type' => 'icon', '#pack_id' => 'my_pack', '#icon_id' => 'home', '#settings' => ['size' => 32]];
```
