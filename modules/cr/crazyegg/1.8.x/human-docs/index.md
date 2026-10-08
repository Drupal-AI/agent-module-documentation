# Crazy Egg — manual setup guide

**Crazy Egg** (`crazyegg`) is the official module for adding the
[Crazy Egg](https://www.crazyegg.com) tracking snippet to your Drupal site. Crazy Egg
is an on-page analytics service that provides heatmaps, scrollmaps, session
recordings, and A/B tests, and this module is the easy, no-code way to inject its
tracking script into your pages.

Setup is simple: enter your Crazy Egg account number on the settings form, choose
where the script loads and which pages and users it applies to, and save. The module
does the rest — it builds the correct external script URL from your account number
and attaches it to the right pages. All tracking runs in the visitor's browser; the
module makes no external calls from the server.

It's a deliberately thin integration — it has no entities, plugins, or Drush commands,
just a single settings form and one config object. It supports a wide range of Drupal
versions (8 through 12) and defines one permission, *Administer crazy egg*, for who can
manage the settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your account number and control
   where and for whom tracking runs.

## Where it lives in the admin menu

Crazy Egg's settings form is at **Configuration → System → Crazy Egg**
(`/admin/config/system/crazyegg`). You'll need the **Administer crazy egg** permission
(`administer crazy egg`) to reach it.
