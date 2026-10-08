# Saudi National Address — manual setup guide

**Saudi National Address** (`saudi_national_address`) gives your site an
authoritative, reusable source of Saudi Arabia's administrative geography —
**regions → cities → districts** — with full Arabic and English translations,
ready‑made dependent address fields, and a single service that centralises all the
address logic. Instead of hardcoding Saudi geography into your forms, you import
the official reference data once and build on it.

The data is sourced from the `yasseralsamman/saudi-national-address` Composer
package and imported into three translatable taxonomy vocabularies — `sna_region`,
`sna_city` and `sna_district` — covering roughly 13 regions, about 4,500 cities and
thousands of districts, each with English (default) and Arabic names and stored
numeric National Address / SPL identifiers and centre coordinates. You seed and
refresh this data idempotently, either with a Drush command or from an admin form,
using Drupal's Batch API so large imports do not time out.

On top of that data the module gives you two practical building blocks. The
**dependent address fields** are standard entity‑reference fields you attach to any
entity to get a cascading experience: choosing a region filters the available
cities, and choosing a city filters the districts — and a custom selection handler
rejects, on submit, any child that does not belong to the selected parent. The
**AddressResolver** service (`saudi_national_address.address_resolver`) is the
single source of address logic: resolve a full hierarchy from an 11‑digit district
ID, look things up by their National Address ID, run typeahead searches, work with
geo coordinates (nearest city or region, distances), reverse‑geocode a lat/lng back
to a region/city/district, and validate hierarchies — all returning typed,
language‑aware value objects.

The module needs setup rather than working purely on‑enable: you require the
dataset package, enable the module, run the import, and then attach the fields or
call the resolver. It depends on core's **taxonomy, options, field, language and
content_translation** modules. An optional **Select2** submodule can enhance the
dependent selects. On the security side the design is sound: database queries use
the query API with `escapeLike()` (no raw SQL concatenation), and the HTTP
endpoints are appropriately gated — the cascading‑children endpoint exposes only
public geographic reference data, while reverse‑geocode and data import each sit
behind their own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — require the dataset package, install
   the module, and import the data.
2. [Configuration](configuration/index.md) — the import/admin screen, the Drush
   commands, and how the dependent fields and resolver are used.

## Where it lives in the admin menu

The import and management screen is at **Configuration → Regional → Saudi National
Address** (`/admin/config/regional/sna`), gated by the restricted **`administer
sna data`** permission.

## How to use it

After importing, either attach the cascading region → city → district reference
fields to your entities, or call the `saudi_national_address.address_resolver`
service from code. Two HTTP routes support this: `/sna/children/{level}/{parent}`
returns the child terms that power the dependent selects (gated by `access
content`, returning only public geographic data), and `/sna/reverse` performs
coordinate reverse lookup (gated by the dedicated `use sna reverse geocode`
permission).
