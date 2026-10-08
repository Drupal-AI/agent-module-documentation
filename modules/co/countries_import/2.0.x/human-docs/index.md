# Countries — manual setup guide

**Countries** (`countries_import`) is an admin tool that imports the world's
countries — and, since 2.0.x, geographic regions — into your site as reusable,
translatable content. It ships the country and region catalogue (ISO 3166‑1
alpha‑2 codes like `RO`, alpha‑3 codes like `ROU`, names, official names, and flag
images) and turns that data into **taxonomy terms** (or nodes) from an admin form,
so your site instantly has a proper country list to back address fields, shipping
options, entity‑reference selects, and country listings.

The problem it solves is the tedious one of seeding geographic reference data. Hand
these terms don't exist until you create them, and typing 200‑plus countries by
hand — with correct ISO codes and flags — is nobody's idea of a good afternoon.
This module does it in one import run. Because the country/region catalogue is
essentially static reference data, importing is a one‑off (or occasional refresh)
administrative task rather than a live integration, and re‑running the import
refreshes the data.

It's flexible about where the data lands. You choose whether to store countries as
taxonomy terms or as a content type, pick which fields hold each value (ISO‑2,
ISO‑3, flag), choose the **flag format** (SVG, or PNG at 32×16 or 128×64), and
optionally translate the name and official name. In 2.0.x you can also import the
assignment of countries to regions, and import only countries or only regions.

It depends on several core and contrib modules — **File**, **Migrate**, **SVG
Image**, **Content Translation**, and **Token** — and runs entirely behind the
site‑configuration permission, with no public endpoints. It works on Drupal 10.3
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — choose the target vocabulary, map the
   fields, and run the country and region imports.

## Where it lives in the admin menu

The import tool lives at **Configuration → Content authoring → Countries import**:

- Countries settings: `/admin/config/content/countries-import`
- Geographic Regions settings:
  `/admin/config/content/countries-import/geographic-regions`

Both are gated by the **Administer site configuration** permission.
