# NBG Currency — manual setup guide

**NBG Currency** (`nbg_currency`) displays the official Georgian lari (GEL, ₾)
exchange rates published by the **National Bank of Georgia** in a configurable
block. Each block shows the currencies you select, with the published unit count,
the localized currency name, the GEL rate, the change since the previous
publication, and the rate's validity date. New blocks start with the US Dollar and
Euro selected.

It is deliberately narrow in scope. NBG Currency presents the *current* official
NBG publication as a read-only block — indicative reference rates, not commercial
bank buy/sell prices. It does **not** convert arbitrary amounts, store historical
rates, add currency entities, or integrate with Drupal Commerce. If you need those,
the Currency or Commerce Exchanger modules are better fits. NBG Currency's job is a
focused, tidy display of the NBG rates.

There is **no API key and no external service subscription** to set up. The module
fetches the currency list and rates directly from the National Bank of Georgia over
HTTPS, caches them according to NBG's publication schedule, and keeps serving the
last known rates if fresh data can't be fetched. It depends only on core's
**Block** module. When **Tagify** or **Drupal Canvas** are installed it integrates
with them automatically — Tagify turns the currency picker into a searchable tag
field, and Canvas makes the block a placeable component.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate module configuration page**. Everything is configured on the
block itself when you place it, described in "How to use it" below.

## Where it lives in the admin menu

NBG Currency adds no dedicated settings page. You place and configure its block
from **Structure → Block layout** (`/admin/structure/block`). When Drupal Canvas
is installed, the block is also available as a placeable component in the Canvas
editor.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click
   **Place block** in the region where you want the rates to appear.
2. Choose the **NBG Currency** block. In its configuration:
   - **Select the currencies** to display (a new block defaults to US Dollar and
     Euro). With Tagify installed this becomes a searchable tag field; otherwise
     it is a set of checkboxes.
   - **Choose how long to cache the rendered table** — each block sets its own
     rendered-table cache duration independently.
   - **Choose whether to show flag emoji** when available, or use a plain table
     without flags.
3. Save the block. It renders the selected currencies' current NBG rates.
   Georgian currency names are used on Georgian-language pages and English names on
   every other interface language.

> **Note:** If fresh rates cannot be retrieved from NBG, the block continues to
> show the last cached rates. The block is omitted entirely only when no cached
> rates are available at all.
