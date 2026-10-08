# Aemet — manual setup guide

**Aemet** (`aemet`) pulls official Spanish weather forecasts from
[AEMET](https://www.aemet.es/) — the Spanish State Meteorological Agency — through
its free OpenData API, and displays them on your Drupal site as a block. It is
aimed at tourism sites, municipal sites, and any Spanish-language site that wants
to show reliable local weather without hand-building an integration.

Behind the scenes the module wraps AEMET's slightly awkward two-step API (a first
request returns a URL, which the module then fetches for the actual forecast
data) inside a tidy client service, and caches the results so your site is not
hammering the API on every page view. A block called **Prediction Hourly** renders
the hourly forecast for a specific Spanish locality.

To use it you need a **free AEMET OpenData API key**. You request one from AEMET,
paste it into the module's settings form, choose how long forecasts should be
cached, then place and configure the block. The key is sent to AEMET over HTTPS.

The key is stored in the module's configuration (a textarea on the settings
form). The module talks to AEMET over normal, verified HTTPS.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your AEMET API key, set the
   cache lifetime, and place the forecast block.

## Where it lives in the admin menu

The settings form is at **Configuration → Services → Aemet**
(`/admin/config/services/aemet`), reachable by users with the *Administer site
configuration* permission. The forecast block is placed from **Structure → Block
layout** like any other block.
