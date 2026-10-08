# Tcmb — manual setup guide

**Tcmb** (`tcmb`) fetches the official daily exchange rates published by the
**TCMB** (the Central Bank of the Republic of Turkey) — and gold prices — and
displays them on your site in a tidy table. If you run a finance, e‑commerce or
news site that needs to show up‑to‑date Turkish Lira exchange rates, this module
retrieves the central bank's own data and renders it through a block you can place
wherever you like.

The setup has two parts: on the **settings page** you tell the module which
currency codes you want to track, and on the **Block layout** page you place the
Tcmb currency block into a region of your theme. The module's docs also mention a
`tcmb_json` submodule that exposes the rates as a public, read‑only JSON feed —
useful if you want to consume the reference data elsewhere. Bear in mind that feed
is public reference data by design, so anyone who can reach the endpoint can read
the rates. The module supports Drupal 9, 10 and 11 and provides its own permission.

One environment requirement to note: Tcmb fetches remote data using PHP's URL file
functions, so your server needs **`allow_url_fopen`** turned on in `php.ini`.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and check the `allow_url_fopen` requirement.
2. [Configuration](configuration/index.md) — set your currency codes and place the
   rates block.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Tcmb settings**
(`/admin/config/system/tcmb-settings`). The display block is added from
**Structure → Block layout** (`/admin/structure/block`).
