<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Entity Reference & Better Options widgets + form elements

## Install & enable

```bash
composer require drupal/better_entity_reference
drush en better_entity_reference -y
```

Core only. Then on **Manage form display** pick the widget for the field type; optionally pick the
**Better Tags** formatter on **Manage display**.

## The two reference/list widgets

- **`better_entity_reference_tags`** — `EntityReferenceTagsWidget`
  (`src/Plugin/Field/FieldWidget/EntityReferenceTagsWidget.php`). For `entity_reference` fields,
  any selection handler including views. The value is stored through core's normal input, so with
  JS off the field is a plain autocomplete (settings `match_operator`, `match_limit`, `size`,
  `placeholder` control that fallback). A broken handler falls back to autocomplete rather than
  breaking the form.
- **`better_options_tags`** — `OptionsTagsWidget` (`OptionsTagsWidget.php`). For
  `list_string` / `list_integer` / `list_float` fields; shows the field's allowed values as tags.

Both render the value with the `better_entity_reference` / `better_options` form element (below).

## Widget settings (config schema: `field.widget.settings.better_entity_reference_tags` / `.better_options_tags`)

Booleans/strings/ints, all defaulted in the widget's `defaultSettings()`:

- Colors: `colored` (off), `color_mode` (`random` | shades | fixed), `shade_color` (`#2563eb`),
  `color_style` (`stroke` | `fill`).
- Popover toolbar: `show_search` (on), `search_match` (`contains`|`starts_with`), `show_sort` (on),
  `show_filter` (on), `glossary` (off). Reference-only: `parents_first` (off), `parent` (a term id
  restricting offered terms, 0 = any).
- List behavior: `show_all` (off), `items_limit` (10), `draggable` (on), `confirm_remove` (off),
  `show_clear_all` (on), `enable_undo` (on), `undo_timeout` (10), `show_tooltips` /
  `show_tag_tooltips` (on). Reference-only: `show_edit_links` (on).
- On-demand loading (reference-only): `on_demand` (`auto`|`always`|`never`), `lazy_threshold`
  (250). Automatic loads options lazily above the threshold — taxonomy browses folder levels on
  demand; other/views handlers use live server-side search as you type.

## Form elements (for custom forms)

`src/Element/BetterOptions.php` (`#[FormElement('better_options')]`) is the base;
`src/Element/BetterEntityReference.php` extends it (`#[FormElement('better_entity_reference')]`).

```php
$form['tags'] = [
  '#type' => 'better_entity_reference',
  '#title' => $this->t('Tags'),
  '#target_type' => 'taxonomy_term',
  '#target_bundles' => ['tags'],
  '#default_value' => [12, 34],   // ordered array of entity ids
];

$form['colors'] = [
  '#type' => 'better_options',
  '#title' => $this->t('Colors'),
  '#options' => ['red' => 'Red', 'blue' => 'Blue'],  // keys must not contain commas
  '#colored' => TRUE,
  '#options_meta' => ['red' => ['color' => '#d72222', 'description' => 'Warm']],
];
```

Shared properties: `#colored`, `#color_base` (accepts `fixed:#hex`), `#color_style`,
`#show_search`, `#search_match`, `#show_sort`, `#show_filter`, `#glossary`, `#parents_first`,
`#show_tooltips`, `#show_tag_tooltips`, `#tooltip_parts`, `#items_limit`, `#show_all`,
`#draggable`, `#single` (picking replaces the value), `#max_items` (0 = unlimited).
Entity-only: `#parent`, `#lazy`, `#live_search`, `#auto_create`, `#auto_create_bundle`.
`#options_meta` per option: `color`, `text`, `description`, `created`, `type`, `bundle`, `status`,
`parents`, `parent_id`/`parent_ids`. `BetterOptions` validates `#options_meta['color']` against a
hex regex before it reaches the DOM.

## Folder browse & live search (endpoints)

Taxonomy lazy mode calls **`better_entity_reference.browse`**
(`BrowseController`): lists one folder level or searches the vocabulary, CSRF-token bound to the
bundle set + configured root, capped at 50, `loadTree(..., TRUE)` results filtered by
`$term->access('view')`. Non-taxonomy live search calls **`better_entity_reference.search`**
(`SearchController`) through the field's own selection handler, using the same hash-validated
`entity_autocomplete` selection-settings key core's autocomplete uses.

## Quick create

If the field allows auto-create and the user may create the bundle, the popover shows a "+ New ..."
row. It posts to **`better_entity_reference.quick_create`** (`QuickCreateController::createEntity`),
which validates a type/bundle-bound CSRF token, checks `createAccess`, applies flood control
(50 creations/hour/user), validates the entity, and returns its option metadata. Terms can be
created under a parent folder. Typing an existing label picks it instead of duplicating.

## Tag colors (`ColorGenerator`, `src/ColorGenerator.php`)

With coloring on, an entity's own color wins (`getColor()` method or a `color` / `field_color`
field, validated to `#rgb`/`#rrggbb`), else `ColorGenerator` derives a stable color from
type+id+language. Modes: random hue, `shadeFromSeed()` (shades of `shade_color`), fixed
(`fixed:#hex`). Fill style computes readable text via `contrastColor()` (YIQ). Alterable through
`hook_better_entity_reference_option_alter()`.
