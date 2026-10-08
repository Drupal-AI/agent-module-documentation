# DaData API — manual setup guide

**DaData API** (`dadata_api`) provides integration with the **DaData** service — a
data‑suggestion and enrichment API widely used for Russian addresses, companies,
banks, and other reference data. It gives Drupal the connection and the
suggestion/enrichment functionality so forms and code can autocomplete and
validate values against DaData.

This is deliberately a **developer‑oriented** module: on its own it doesn't add
much visible functionality — it exposes DaData's capabilities so a developer can
build on them. Those capabilities include the **Base API** (version, balance, and
usage statistics), the **Cleaner API** (data standardization and correction), and
the **Suggestions API** (directory search, nearest‑address lookup, IP location).

Two points matter before you turn it on. Your **DaData API token is a
credential** — store it as a secret rather than committing it. And DaData is an
external service, so the values users type (addresses, company names, and the
like) are **sent to DaData** for suggestions — a data‑handling / privacy
consideration you should account for. The module is configured on its own settings
form, provides its own permissions, and supports Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your DaData token and set which
   lookups are used.

## Where it lives in the admin menu

Once enabled, DaData API adds a settings form (the `dadata_api.settings` route)
where you enter your API token. Because the module is mainly a building block for
developers, most of its power is used from custom code that calls the Base,
Cleaner, and Suggestions APIs it wraps. See [Configuration](configuration/index.md)
for entering credentials.
