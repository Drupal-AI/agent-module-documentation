# NovaPoshta API — manual setup guide

**NovaPoshta API** (project `basket_novaposhta`, module machine name `novaposhta`)
integrates Nova Poshta — Ukraine's dominant parcel carrier — with the **Basket**
online-store module. Nova Poshta is *warehouse-based*: customers pick a branch to
collect their parcel from rather than typing a street address. The module's main
job is to keep the carrier's city and warehouse reference data available for
selection at checkout, attach the chosen warehouse to the order, and surface that
carrier data in the admin order listings.

One naming detail trips people up: the drupal.org **project** is
`basket_novaposhta`, but the **module** you enable is `novaposhta`. You install
with `composer require drupal/basket_novaposhta` and then enable `novaposhta`. It
depends on the `basket` store module and core **Views** — it is *not* a Drupal
Commerce module, so you need a Basket-based store for it to plug into.

Once enabled, it exposes a settings form at
**Configuration → Development → NovaPoshta** (`/admin/config/development/novaposhta`)
where you enter your Nova Poshta API credentials. It also ships console (Drush)
commands, typically used to refresh the city/warehouse reference data, and adds
carrier columns to Views listings of orders. Interface translations are bundled,
reflecting a primarily Ukrainian-language audience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   `novaposhta` module (note the project/module name mismatch).
2. [Configuration](configuration/index.md) — the settings form where you enter the
   Nova Poshta API credentials.

## Where it lives in the admin menu

After enabling, the settings form sits at **Configuration → Development →
NovaPoshta** (`/admin/config/development/novaposhta`). Carrier data also appears in
the dedicated Nova Poshta admin screens and in the order Views listings.

## How to use it

The typical flow: install and enable the module against a working Basket store,
enter your Nova Poshta API credentials on the settings form, then run the shipped
console command(s) to pull down the current city and warehouse reference data
(`drush list | grep -i novaposhta` shows what is available). From then on,
customers choosing Nova Poshta delivery at checkout can search for their city and
pick a branch, and that warehouse is stored on their order. Refresh the reference
data periodically — automating the console command via cron keeps the branch list
current.
