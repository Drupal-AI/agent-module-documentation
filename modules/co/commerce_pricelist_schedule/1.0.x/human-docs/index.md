# Commerce Pricelist Schedule — manual setup guide

**Commerce Pricelist Schedule** (`commerce_pricelist_schedule`) extends the
**Commerce Pricelist** module with the ability to **schedule CSV price-list
imports** to run at a time you choose, rather than importing them by hand.

The problem it solves is keeping prices up to date without someone remembering to
run an import: you prepare a price-list CSV as you normally would, then schedule
its import for a specific time (imports typically run via cron). This is handy for
recurring price updates or coordinating a price change to go live at a set moment.

It depends on the **Commerce Pricelist** module (`commerce_pricelist`) and
supports Drupal 10 and 11. It has no configuration form and no access-control role
of its own — you use it directly from the price-list pages (see "How to use it").

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — scheduling is done from each
price list's own pages, described in "How to use it" below.

## Where it lives in the admin menu

Commerce Pricelist Schedule adds a **Scheduled Imports** tab on price-list pages
(provided by Commerce Pricelist). It does not add a separate settings page.

## How to use it

1. Navigate to the **Scheduled Imports** tab on any price-list page.
2. Click **Schedule Import** and set up the import exactly as you would a normal
   price-list import (choose the CSV and the usual import options), then set the
   time it should run.
3. The import runs automatically at the scheduled time (typically on the next cron
   run at or after that time).
4. You can **cancel** a scheduled import from the same tab if plans change.

> **Data-handling tip:** The import CSV you upload is stored in a private (or, if no
> private file system is configured, temporary) directory and is downloadable only by
> administrators. Scheduling requires the *administer commerce_pricelist* permission.

> **Note:** This release is a beta (1.0.0-beta1) and the module is *minimally
> maintained*. Test the scheduled-import flow before relying on it for critical
> price changes.
