# Closest Zip Code — manual setup guide

**Closest Zip Code** (`closest_zip_code`) answers one question in code: given a US
(or US‑territory) ZIP code and a list of other ZIP codes, which of them is
nearest? It is a small, offline developer API — there is **no user interface, no
settings page, and no admin route**. You call it from PHP or Drush and it returns
the closest ZIP code(s), ordered nearest‑first, with the distance in kilometres
and miles.

All the geography is bundled: the module ships a local CSV of ZIP‑code
latitude/longitude coordinates (`data/zipcodes.csv`) and computes distances with
the Vincenty great‑circle formula. Because nothing is fetched over the network,
results are limited to that dataset but are fast and work completely offline —
there is no external API to sign up for and no API key to store.

There is no built‑in access control, and the module exposes no endpoint of its
own, so it is safe by default. If you ever surface its results to end users, wrap
the call in your own permission‑checked code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form and
no admin UI. See "How to use it" below for the code entry point.

## How to use it

The entry point is a singleton `App` class. Pass your reference ZIP code and an
array of candidate ZIP codes — always as **strings**, because leading zeros
matter:

```php
$result = \Drupal\closest_zip_code\ClosestZipCode\App::instance()
  ->closestZipCode('00720', ['00723', '00725', '00727']);
```

The return value is an array containing the resolved `zip`, its `lat`/`lon`, an
`errors` list (holding any candidate ZIP that could not be resolved), and a
`zips` list ordered nearest‑first, where each entry carries its distance in `km`
and `miles`. Input is validated as numeric and bounded to the 500–99999 range;
out‑of‑range or non‑numeric values are captured in `errors` rather than crashing.

You can try it straight from the command line with Drush:

```bash
drush ev 'print_r(\Drupal\closest_zip_code\ClosestZipCode\App::instance()->closestZipCode("00720", ["00723","00725"]));'
```
