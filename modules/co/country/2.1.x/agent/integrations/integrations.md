<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integrations — Views, Facets, Feeds

## Views filter & sort

- **Filter** `\Drupal\country\Plugin\views\filter\CountryItem` — `@ViewsFilter("country_item")`.
  Config schema `views.filter.country_item` has a `type` (selection type) option; the exposed
  filter value schema `views.filter_value.country_item` also carries `type`.
- **Sort** `\Drupal\country\Plugin\views\sort\CountryItem` — `@ViewsSort("country_item")`.
  Option `default_sort` (boolean): when TRUE, sort by **ISO code** rather than by name.

Both attach automatically to any `country` field in the Views UI (add it as a filter/sort
criterion on the country field).

## Facets processor

`\Drupal\country\Plugin\facets\processor\CountryName` — `@FacetsProcessor(id = "country_name",
label = "Country name")`. Enable it on a facet built from a country field so the facet links
show the **country name** instead of the raw ISO code. (Requires the Facets module.)

## Feeds target

`\Drupal\country\Feeds\Target\Country` — `@FeedsTarget(id = "country")`. Lets a Feeds
importer map an incoming column to a `country` field. (Requires the Feeds module; declared as
a dev/optional dependency.)

None of these require configuration beyond selecting them in the respective module's UI.
