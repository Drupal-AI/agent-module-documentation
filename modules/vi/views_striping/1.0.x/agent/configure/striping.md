# Configure row striping on a view

There is no settings page. Striping is turned on in two places: a **global** Views switch that
enables the display extender, then a **per-view** choice of striping type in the table Format
settings.

## 1. Enable the display extender (once, site-wide)

`/admin/structure/views/settings/advanced` → **Display Extenders** section → tick **Row striping**
→ Save. This is core Views' extender registry, stored in the `views.settings` config object under
`display_extenders` (a list of extender plugin ids). The extender this module provides is
`views_striping`.

Enable it with drush/PHP instead of the UI:

```php
$config = \Drupal::configFactory()->getEditable('views.settings');
$extenders = $config->get('display_extenders') ?: [];
$extenders[] = 'views_striping';
$config->set('display_extenders', array_values(array_unique($extenders)))->save();
```

Uninstall caveat (from the README / core issue 2635728): **untick Row striping here before
uninstalling the module**, otherwise the leftover extender id breaks Views.

## 2. Pick a striping type (per view display)

Edit the view, use the **table** style, then open **Format → Settings**. The extender adds a
**Striping type** radio group (`#type => radios`, option key `striping_type`):

| Value | Label | Effect |
| --- | --- | --- |
| `` (empty) | None | No classes added (default) |
| `alternating` | Alternating | Adds `odd`/`even`, flipping every row |
| `field_value` | Field value | Adds `odd`/`even`, flipping each time a chosen field's rendered value changes between adjacent rows |

Choosing **Field value** reveals a required **Striping field** select (option key `striping_field`,
shown via `#states`); its options are the view's own field handlers (`$view->getHandlers('field')`,
labelled by each field's label or id). Adjacent rows with the same value in that field share a
stripe.

The form only appears when the style plugin's id is one of the supported ones
(`table`, `views_aggregator_plugin_style_table`) and the style reports `usesRowClass() === TRUE`.

Options are stored in the view config entity at
`display_options.display_extenders.views_striping.{striping_type,striping_field}` for the display.
Example — set them directly on a saved view:

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = &$view->getDisplay('default');
$display['display_options']['display_extenders']['views_striping'] = [
  'striping_type'  => 'field_value',
  'striping_field' => 'title',
];
$view->save();
```

## What happens at render time

1. Core themes the table via `template_preprocess_views_view_table` (or the aggregator's
   `template_preprocess_views_aggregator_results_table`). This module's implementations —
   `views_striping_preprocess_views_view_table` / `views_striping_preprocess_views_aggregator_results_table`
   in `views_striping.module` — look up the display's extenders; if the `views_striping` extender is
   present and its `striping_type` is non-empty, they call `$extender->preprocessViewStyle($variables)`.
2. `ViewsStriping::preprocessViewStyle()` instantiates the chosen striping-type plugin and calls
   `preprocessViewRows($this, $variables['rows'])`.
3. The plugin loops the rows and calls `$row['attributes']->addClass('odd'|'even')` — a Drupal
   `Attribute` object, so the class value is rendered escaped by Twig.
   - `alternating`: `$index % 2 ? 'even' : 'odd'` (row 0 → `odd`).
   - `field_value`: starts at `odd`, compares each row's `$row['columns'][$field_name]['content']`
     (the whole render array, so identical formatted output counts as unchanged) against the
     previous row, and flips `odd`↔`even` on a change.

## Styling

Core ships no CSS for these classes. Define `.odd` / `.even` (scoped to your view/table) in your
theme. See drupal.org issue 3332049.

## Config schema

The module ships **no** `config/schema`; the two options ride inside the View entity's existing
`display_extenders` schema. `configure` route: none.
