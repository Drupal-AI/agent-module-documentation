<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Country provides a simple `country` field type that stores a two-letter ISO 3166 country code, with select and autocomplete widgets and formatters that render either the country name or the raw code.

---

The module adds a Drupal field type `country` whose stored value is a 2-character ISO country code (schema column `value`, char length 2, indexed), resolved to a human-readable name through core's `country_manager` service. It ships two widgets — `country_default` (a select list, the default) and `country_autocomplete` (a text autocomplete backed by the `country.autocomplete` route, with `size`/`placeholder` settings) — plus enables core's `options_buttons` (checkboxes/radios) and, when the Tagify module is present, `tagify_select_widget`. Two formatters are provided: `country_default` (renders the localized country name, also the default) and `country_iso_code` (renders the raw ISO code). A per-field/storage setting `selectable_countries` restricts which countries are offered; the `country.field.manager` service (`getSelectableCountries()`, `getList()`) resolves the effective list. It also registers a reusable `country` form element (extending core Select), a Views filter and sort (both `country_item`, the sort optionally ordering by ISO code), a Facets processor `country_name` (shows names instead of codes in facet links), a Feeds target `country`, and a token `[…:country_original_name]` yielding the country name. The module has no admin settings page (`configure: null`), no permissions and no Drush commands; everything is configured through the standard Field UI (Manage fields / form display / display). This 2.2.x branch requires Drupal **^11.3 || ^12** (Drupal 10 support was dropped) and moves its hook implementations into OOP `#[Hook]` classes under `src/Hook/`. `ext-intl` is suggested for correct sorting of non-English country names.

---

- Add a "Country" field to a content type, user profile, taxonomy term or any fieldable entity.
- Store a person's or organization's country as a standard ISO 3166 alpha-2 code.
- Present country selection as a dropdown (`country_default` select widget).
- Present country selection as a type-ahead autocomplete (`country_autocomplete` widget).
- Offer country selection as checkboxes or radio buttons (`options_buttons` widget).
- Restrict the offered countries to a subset via the `selectable_countries` field setting.
- Display the field as a localized country name (`country_default` formatter).
- Display the field as the raw ISO code, e.g. `US`, `GB` (`country_iso_code` formatter).
- Set a placeholder and input size on the autocomplete widget.
- Filter a View by country (`country_item` Views filter), globally or per bundle.
- Sort a View by country, either by name or by ISO code (`country_item` Views sort).
- Show country names instead of codes in a Facets facet (`country_name` processor).
- Import a country value from a feed with the `country` Feeds target.
- Print a node's country name in text/emails via the `country_original_name` token.
- Reuse the `country` render/form element in a custom form (a pre-populated country select).
- Build a "shipping country" or "billing country" field for a commerce-style entity.
- Capture the nationality of members in a membership site.
- Record the country of origin for products or media assets.
- Standardize country storage across many content types using one field type.
- Programmatically read the effective selectable-country list via `country.field.manager`.
- Localize displayed country names to the site/content language automatically.
- Provide an exposed country filter on a directory or listing View.
- Migrate legacy free-text country data into a validated ISO-code field.
- Group or facet content by country in a search index.
- Populate a country select with only the countries you operate in.
- Prefill the widget from the visitor's country when the ip2country module is installed.
