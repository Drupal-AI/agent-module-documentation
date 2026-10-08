# Facet Range list Item — manual setup guide

**Facet Range list Item** (`facet_range_list_item`) lets a search facet group a
numeric field into your own custom ranges instead of listing every individual value.
So a "duration" facet can show a few meaningful buckets — *0–20 Minutes*,
*20–40 Minutes*, *40+ Minutes* — rather than a long, noisy list of exact numbers.

It plugs into the [Facets](https://www.drupal.org/project/facets) and
[Search API](https://www.drupal.org/project/search_api) modules by adding a facet
**processor** and a matching **query type**. You enable the processor on a number
facet and type your ranges, one per line, in a simple `start-stop|label` format. At
search time the module maps each indexed value into the range it falls in and
filters on it; in the facet UI it shows your friendly labels and the count per range.

There is no settings page of its own — all the configuration lives on the facet's
edit form — and it adds no permissions. It works with integer, decimal, and float
fields, and supports Drupal 8.8 all the way through 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it on a facet at
**Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`).

## How to use it

You need a numeric field already indexed with Search API and a facet created on it.
Then:

1. Go to **Configuration → Search and metadata → Facets** and edit your numeric
   facet.
2. Enable the **Range List Item Processor** checkbox.
3. In its **Enter Range** textarea, add one range per line as `key|label`, where the
   key is a numeric `start-stop` range:

   ```
   0-20|0-20 Minutes
   20-40|20-40 Minutes
   40-999|40+ Minutes
   ```

   Each range's start and stop must be numeric (integer or decimal).
4. Save. The facet now shows your labels, and selecting one filters results to that
   numeric range.

A few things worth knowing:

- **Ranges are inclusive on both ends** (a value counts if it is `>=` start and
  `<=` stop). If two ranges overlap, a value falls into the first one you defined.
- **For an open-ended top bucket** like "40 and above", just use a large stop value,
  e.g. `40-999|40+ Minutes`.
- **The underlying data is unchanged** — the module only re-labels and re-buckets
  values for display and filtering, so you can adjust labels or ranges any time
  without reindexing your field.

Typical uses: price bands (`0-50|Under $50`), star-rating ranges
(`4-5|4 stars & up`), age or year buckets, and distance/size/weight ranges — any
time an exact-value numeric facet would be too granular to be useful.
