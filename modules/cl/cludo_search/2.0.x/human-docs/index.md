# Cludo Search — manual setup guide

**Cludo Search** (`cludo_search`) connects your Drupal site to
[Cludo](https://www.cludo.com/), a hosted (SaaS) site‑search product. Instead of
building and querying a local search index (as you would with Search API and Solr),
Cludo's JavaScript widget runs in your visitors' browsers and queries Cludo's API
directly. Cludo's own crawler indexes your site behind the scenes.

The module gives you the pieces you need to wire this up: a configuration page where
you enter your Cludo account's **public** customer ID and engine ID and point Drupal
at your search results page, plus a **search block** and a search page so you can
place Cludo search wherever your theme needs it. (The module loads Cludo's widget
script in the browser — it makes no server-side call to Cludo.)

Choose Cludo when you want to outsource site search for its relevance tuning,
analytics and merchandising features rather than run your own Solr/Search API
infrastructure. The trade‑off is the usual SaaS one: less infrastructure to
operate, but a dependency on Cludo's availability and data handling. The customer ID
and engine ID are **public** widget identifiers — they appear in your page source by
design, so there is no secret to protect here. Do be aware that visitors' **search
terms are sent to Cludo** (from the browser). (This module is a community project and
is not sponsored or supported by Cludo.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Cludo customer and engine
   IDs, set the search page path, and place the search block.

## Where it lives in the admin menu

After enabling, open the Cludo Search settings page (under **Configuration**,
reachable from the module's link on the Extend/modules list) to enter your Cludo
customer and engine IDs and the search page path. Administering the settings is
controlled by the module's own permission.
