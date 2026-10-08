# CIS currencies rates — manual setup guide

**CIS currencies rates** (`rcr`) fetches the USD and EUR exchange rates against a
set of CIS national currencies — the Russian ruble, Kazakh tenge, Kyrgyz som,
Azerbaijani manat, Belarusian ruble, and Ukrainian hryvnia — directly from each
country's national-bank feed, and displays them in a block. Rates are stored in
Drupal's State system and refreshed either automatically on cron or on demand
from the command line.

It does not depend on Commerce, so you can use it on any site — not just shops.
If you want to reuse the fetched rates in your own custom code, they are
available from State, for example
`$val = \Drupal::state()->get('rcr.eur_russia');` (where `eur`/`usd` is the
currency and `russia`, `kazakhstan`, `kyrgyzstan`, `azerbaijan`, or `ukraine` is
the country). Since the 2.x line you can select several countries at once and add
a separate block per country.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form lives at **Configuration → System → Currency settings**
(`/admin/config/system/currency-settings`) and is protected by the **Change
currency rate** permission. The rates block is placed from **Structure → Block
layout** (`/admin/structure/block`).

## How to set it up and use it

1. **Configure the sources.** Go to
   `/admin/config/system/currency-settings` and choose:
   - the **country / national bank** whose feed you want (each country maps to a
     fixed national-bank feed — e.g. cbr.ru, nationalbank.kz, nbkr.kg, cbar.az,
     nbrb.by, bank.gov.ua);
   - the **update type** — *cron* (rates refresh automatically) or *manual*;
   - optionally, a **manual override rate** and a **commission** markup to add on
     top of the fetched rate when it is displayed.

2. **Get the first rates.** After configuring, you **must** run cron or the Drush
   command once so the initial rates are downloaded and stored:

   ```bash
   drush rcr-getrates
   ```

   Thereafter, cron keeps them current (in cron update mode), or you re-run the
   command whenever you want a manual refresh.

3. **Place the block.** At **Structure → Block layout**, add the **RCR** rates
   block to the region where you want the USD/EUR values shown. With multiple
   countries selected you can add several blocks, each showing a different
   country's rates. The block renders the stored values plus any commission you
   configured.

> There is no separate configuration page in this guide because the settings form
> above is short and is best followed in order with the block placement — the two
> steps only make sense together.
