# Countries Info — agent index

Installs a pre-populated "Countries information" taxonomy vocabulary (~249 ISO 3166-1 countries) with
ISO2/ISO3/numeric codes, official name, and continent. Pure reference data — no admin UI, permissions,
routes, Drush, or config schema. Depends on core `taxonomy`, `options`, `text`, `path`. `configure` null.

- **The vocabulary, field machine names/types, term structure, path aliases, and how to query/reference** →
  [configure/taxonomy.md](configure/taxonomy.md)

Key facts:
- Vocabulary id: `cit_countries_information`. Terms seeded from `data/countries.csv` on install.
- Fields on each term: `field_citf_official_name` (string), `field_citf_iso2_code` (string),
  `field_citf_iso3_code` (string), `field_citf_iso_num_code` (integer),
  `field_citf_continent` (list_string: AF/AN/AS/EU/SA/NA/OC).
- Term `name` = common name; path alias `/country-info/<ISO2>`; CSV `enabled` → term published status.
- Uninstall deletes the vocabulary and all its terms.
