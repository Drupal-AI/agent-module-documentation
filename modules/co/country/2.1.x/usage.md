<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Country provides a simple `country` field type that stores a two-letter ISO 3166 country code, with select and autocomplete widgets and formatters that render either the country name or the raw code.

---

The module adds a Drupal field type `country` whose stored value is a 2-character ISO country code (schema column `value`, max length 2), resolved to a human-readable name through core's `country_manager` service. It ships two widgets — `country_default` (a select list, the default) and `country_autocomplete` (a text autocomplete backed by the `country.autocomplete` route, with `size`/`placeholder` settings) — and two formatters — `country_default` (renders the localized country name, also the default) and `country_iso_code` (renders the raw ISO code). A per-field/storage setting `selectable_countries` restricts which countries are offered; the `country.field.manager` service (`getSelectableCountries()`, `getList()`) resolves the effective list. It also registers a reusable `country` form element (extending core Select), a Views filter and sort (both `country_item`, the sort optionally ordering by ISO code), a Facets processor `country_name` (shows names instead of codes in facet links), a Feeds target `country`, and a token `[…:country_original_name]` yielding the country name. The module has no admin settings page (`configure: null`), no permissions and no Drush commands; everything is configured through the standard Field UI (Manage fields / form display / display). `ext-intl` is suggested for correct sorting of non-English country names.

---

- Add a "Country" field to a content type, user profile, taxonomy term or any fieldable entity.
- Store a person's or organization's country as a standard ISO 3166 alpha-2 code.
- Present country selection as a dropdown (`country_default` select widget).
- Present country selection as a type-ahead autocomplete (`country_autocomplete` widget).
- Restrict the offered countries to a subset via the `selectable_countries` field setting.
- Display the field as a localized country name (`country_default` formatter).
- Display the field as the raw ISO code, e.g. `US`, `GB` (`country_iso_code` formatter).
- Set a placeholder and input size on the autocomplete widget.
- Filter a View by country (`country_item` Views filter).
- Sort a View by country, either by name or by ISO code (`country_item` Views sort).
- Show country names instead of codes in a Facets facet (`country_name` processor).
- Import a country value from a feed with the `country` Feeds target.
- Print a node's country name in text/emails via the `country_original_name` token.
- Reuse the `country` render/form element in a custom form (a pre-populated country select).
- Build a "shipping country" or "billing country" field for a commerce-style entity.
- Capture the nationality of members in a membership site.
- Record the country of origin for products or media assets.
- Collect the country on a webform-style content entity submission.
- Standardize country storage across many content types using one field type.
- Programmatically read the effective selectable-country list via `country.field.manager`.
- Localize displayed country names to the site/content language automatically.
- Provide an exposed country filter on a directory or listing View.
- Migrate legacy free-text country data into a validated ISO-code field.
- Group or facet content by country in a search index.
- Populate a country select with only the countries you operate in.
