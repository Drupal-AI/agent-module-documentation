# Countries Info — manual setup guide

**Countries Info** (`countries_info`) installs a ready-to-use **"Countries information"**
taxonomy vocabulary, pre-populated with every country (~249 terms) as ISO 3166-1 reference data.
Each country term carries its common name, official name, ISO alpha-2 code, ISO alpha-3 code, UN
numeric code, and continent — so you can reference countries as ordinary entities anywhere in
Drupal without hand-entering 200+ terms yourself.

Because the countries are plain taxonomy terms, they slot straight into the tools you already
use: add an entity-reference field to a content type to let editors pick a country, filter or
facet content by country, drive Views listings, or build a country landing page. Every term also
gets an automatic URL alias at `/country-info/<ISO2>`, and terms can be individually unpublished
to hide countries you do not want offered.

There is **nothing to configure** — no settings page, no permissions, no routes, no Drush, and no
config schema of its own. Enabling the module builds the vocabulary and seeds the terms from a
bundled CSV; uninstalling it deletes the vocabulary and all its terms. It depends on core's
**Taxonomy**, **Options**, **Text**, and **Path** modules and works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — the exact field machine names and query snippets —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (the vocabulary
   and all country terms are created on enable).

## How to use it

Enabling the module creates a vocabulary you then use through core Taxonomy — there is no setup
step of its own.

**The vocabulary:** machine name `cit_countries_information`, label *Countries information*,
populated with ~249 country terms on install. Browse them at **Structure → Taxonomy → Countries
information**.

**Each country term holds:**

| Field | Holds | Example (Taiwan) |
|---|---|---|
| Term name | Common country name | `Taiwan` |
| `field_citf_official_name` | Official name | `Taiwan, Republic of China` |
| `field_citf_iso2_code` | ISO 3166-1 alpha-2 | `TW` |
| `field_citf_iso3_code` | ISO 3166-1 alpha-3 | `TWN` |
| `field_citf_iso_num_code` | ISO 3166-1 numeric-3 | `158` |
| `field_citf_continent` | Continent code | `AS` |

Continent codes are `AF` Africa, `AN` Antarctica, `AS` Asia, `EU` Europe, `SA` Latin America and
the Caribbean, `NA` Northern America, `OC` Oceania. Each term also gets a `/country-info/<ISO2>`
URL alias.

**Common ways to use it:**

- **Let editors pick a country:** add an **entity reference** field (targeting taxonomy terms) to
  a content type and restrict it to the `cit_countries_information` vocabulary. Editors then get a
  country autocomplete/select sourced from the terms.
- **Filter, facet, and list:** the terms work as Views arguments and filters, as Search
  API / facets sources, and as entity-reference targets — anywhere taxonomy terms are accepted.
- **Hide specific countries:** unpublish individual terms from the standard taxonomy term list to
  keep them out of selection.
- **Group by continent:** use `field_citf_continent` to group or filter countries by region.

Access to the terms follows core taxonomy permissions. Code examples for loading a country by
ISO2 code are in [`agent/configure/taxonomy.md`](../agent/configure/taxonomy.md).

## Where it lives in the admin menu

The vocabulary appears under **Structure → Taxonomy → Countries information**
(`/admin/structure/taxonomy/manage/cit_countries_information/overview`). There is no dedicated
settings page for the module — it is pure reference data managed through core Taxonomy.
