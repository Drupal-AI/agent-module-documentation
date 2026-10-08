<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integrations — Views, Facets, Feeds, Tagify

## Views filter & sort

- **Filter** `\Drupal\country\Plugin\views\filter\CountryItem` — `@ViewsFilter("country_item")`,
  extends `ManyToOne`. Options: `country_target_bundle` (default `global`) and `type`
  (`select` dropdown or `textfield` autocomplete). Acts as a non-filter when no value is
  chosen. Config schema `views.filter.country_item` / value schema `views.filter_value.country_item`
  both carry `type`.
- **Sort** `\Drupal\country\Plugin\views\sort\CountryItem` — `@ViewsSort("country_item")`,
  extends `SortPluginBase`. Option `default_sort` (boolean): when set it sorts by **ISO code**
  (default core sort); otherwise it orders by **country name** using a SQL `FIELD()` formula
  built from the (quoted) country-code list.

The filter/sort are attached to any `country` field through `hook_field_views_data_alter`
(`CountryViewsHooks::fieldViewsDataAlter`), which rewrites the field's filter/sort `id` to
`country_item`.

## Facets processor

`\Drupal\country\Plugin\facets\processor\CountryName` — `@FacetsProcessor(id = "country_name",
label = "Country name")`, build stage. Enable it on a facet built from a country field so the
facet links show the **country name** instead of the raw ISO code (falls back to the code if
unknown). Requires the Facets module (dev/optional dependency).

## Feeds target

`\Drupal\country\Feeds\Target\Country` — `@FeedsTarget(id = "country")`. Lets a Feeds importer
map an incoming column to a `country` field; the incoming value is trimmed and upper-cased
before storage. Requires the Feeds module (dev/optional dependency).

## Tagify (optional)

When the **Tagify** module is installed, the `tagify_select_widget` becomes available for the
`country` field type (added in `hook_field_widget_info_alter`), giving a friendlier tag-style
selection UI.

None of these require configuration beyond selecting them in the respective module's UI.
