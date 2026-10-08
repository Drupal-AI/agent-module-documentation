Countries Info installs a ready-to-use "Countries information" taxonomy vocabulary pre-populated with every country (~249 terms) as ISO 3166-1 data — name, official name, ISO alpha-2, ISO alpha-3, UN numeric code, and continent — so you can reference countries as entities anywhere in Drupal.

---

On install (`countries_info_install`) the module creates the `cit_countries_information` vocabulary plus five fields on its terms and seeds terms from a bundled CSV (`data/countries.csv`): `field_citf_official_name` (string), `field_citf_iso2_code` (string), `field_citf_iso3_code` (string), `field_citf_iso_num_code` (integer), and `field_citf_continent` (list_string, allowed values AF/AN/AS/EU/SA/NA/OC → Africa … Oceania). The term `name` is the common country name and each term gets a URL alias `/country-info/<ISO2>` (requires core `path`); the CSV `enabled` column maps to the term's published `status`, so an admin can unpublish/disable individual countries from the standard taxonomy term list. The vocabulary/field configuration is read from the site's config sync directory when present, otherwise from the module's own `config/` directory. There is no admin settings page, no permissions, no routes, no Drush command, and no config schema of its own — it is pure reference data built on core Taxonomy/Options/Text/Path. Uninstalling (`countries_info_uninstall`) deletes the `cit_countries_information` vocabulary (and its terms). Because countries are ordinary taxonomy terms, they can be used as entity-reference targets, in Views, facets, and search.

---

- Add a standardized country vocabulary to a site without hand-entering 200+ countries.
- Reference a country from a content type via an entity-reference (taxonomy term) field.
- Store a user's or node's country as a term reference for filtering and faceting.
- Look up a country's ISO alpha-2 code (e.g. `TW`).
- Look up a country's ISO alpha-3 code (e.g. `TWN`).
- Look up a country's UN numeric code (ISO 3166-1 numeric-3).
- Display a country's official name alongside its common name.
- Group or filter countries by continent (Africa, Asia, Europe, …).
- Build a country landing page at `/country-info/<ISO2>` using the auto-generated path alias.
- Provide a country select list sourced from taxonomy terms.
- Power Views listings or blocks that iterate over countries.
- Use countries as facet filters in a Search API / facets setup.
- Unpublish (disable) specific countries from the term list to hide them from selection.
- Feed ISO country data into other modules that consume taxonomy terms.
- Localize or override country term names by editing the taxonomy terms.
- Seed reference data consistently across environments (config-driven install).
- Map internal records to standardized ISO country identifiers.
- Add continent-based navigation or grouping to a site.
- Provide autocomplete of countries in content forms via a term-reference widget.
- Remove all country data cleanly by uninstalling the module (vocabulary is deleted).
