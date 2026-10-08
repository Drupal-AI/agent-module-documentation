# Countries Info — vocabulary & fields

There is no settings form. Enabling the module builds a reference-data vocabulary; you interact with
it through core Taxonomy.

## Vocabulary

- Machine name (vid): **`cit_countries_information`**
- Label: "Countries information"
- Populated on install (`countries_info_install`) from `data/countries.csv` (~249 rows).

## Fields on each term

| Field machine name | Type | Holds | Example (Taiwan) |
|---|---|---|---|
| `name` (term label) | — | Common country name | `Taiwan` |
| `field_citf_official_name` | string | Official name | `Taiwan, Republic of China` |
| `field_citf_iso2_code` | string | ISO 3166-1 alpha-2 | `TW` |
| `field_citf_iso3_code` | string | ISO 3166-1 alpha-3 | `TWN` |
| `field_citf_iso_num_code` | integer | ISO 3166-1 numeric-3 | `158` |
| `field_citf_continent` | list_string | Continent code | `AS` |

`field_citf_continent` allowed values: `AF` Africa, `AN` Antarctica, `AS` Asia, `EU` Europe,
`SA` Latin America and the Caribbean, `NA` Northern America, `OC` Oceania.

Each term also gets a path alias `/country-info/<ISO2>` (uppercased ISO2), and the CSV `enabled` column
sets the term's published `status` (so unpublished = disabled country).

## Install internals

`countries_info_install()` reads the vocabulary + field/display config from the site's
`config_sync_directory` if available, otherwise from the module's `config/` directory, creates the
config entities, then loops `data/countries.csv` creating one term per row (skipping the header row).
It is idempotent-ish: it only builds the vocabulary if `cit_countries_information` does not already
exist. `countries_info_uninstall()` deletes the vocabulary (removing all its terms).

## Referencing / querying

Countries are ordinary taxonomy terms — reference them like any vocabulary:

```php
// Load all country terms.
$terms = \Drupal::entityTypeManager()->getStorage('taxonomy_term')
  ->loadByProperties(['vid' => 'cit_countries_information']);

// Find a country by ISO2.
$tw = \Drupal::entityTypeManager()->getStorage('taxonomy_term')
  ->loadByProperties(['vid' => 'cit_countries_information', 'field_citf_iso2_code' => 'TW']);
```

To let editors pick a country, add an **entity reference** field targeting taxonomy terms and restrict
it to the `cit_countries_information` vocabulary. The terms work as Views arguments/filters, facet
sources, and search entities. No module-defined permissions — access follows core taxonomy permissions.
