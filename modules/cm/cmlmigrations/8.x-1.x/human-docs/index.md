# CML Migrations — manual setup guide

**CML Migrations** (`cmlmigrations`) provides the **import side** of a CommerceML
(1C) exchange. It ships migrate configurations that take the catalog, product and
order data received from 1C:Enterprise via CommerceML and import it into Drupal
Commerce entities, built on top of the Migrate framework (Migrate Tools /
Migrate Plus).

Where [CML API](https://www.drupal.org/project/cmlapi) handles the exchange
protocol, CML Migrations turns the received data into real Drupal content:
taxonomy, product variations, and products (with their variation, catalog and image
associations). It also includes tools for debugging the exchange and a helper class
for reporting the correct exchange status back to 1C as a `cml` entity moves through
its exchange states.

This is a **developer/migration module** driven through the Migrate framework and
Drush. The data it imports comes from the 1C exchange, so treat it as external
input; the module has no runtime access role of its own.

**A couple of constraints to know before you start.** By convention, the product's
taxonomy term field must be named **`field_catalog`** and the product image field
must be named **`field_image`** — these names come from the CML Starter structure
this module expects. The migration also adds a **`product_uuid`** field to
variations: if you update the module, run `drush entity-updates`; and if you want to
reinstall the migrations, the module's settings page has buttons to fill or clear
that field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — the settings page, the field
   fill/clear tools, and running the migrations.

## Where it lives in the admin menu

The module's settings page (`cmlmigrations.settings`) is where you configure the
migrations and find the `product_uuid` fill/clear buttons. Imports are run from
there and via the module's **Drush commands**.
