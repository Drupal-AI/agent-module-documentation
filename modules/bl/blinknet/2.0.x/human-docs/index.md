# Blink.net Integration — manual setup guide

**Blink.net Integration** (`blinknet`) is a wrapper for the
[Blink.net](https://www.drupal.org/project/blinknet) advertising/donation service.
It exposes Blink.net's donation and subscription widgets as Drupal **blocks** that
you configure from one central settings form and then place anywhere through Block
Layout.

Use it when you want to put Blink.net donation or subscription calls-to-action on
your site — for example a donation button in a sidebar or a subscription prompt in
a footer. You enter your Blink.net account details once, and the module renders the
appropriate Blink.net embed inside whichever block you place.

The module ships four block variants: a **donation button**, a **donation
container**, a **subscription button**, and a **subscription container** — so you
can choose the button-style or container-style widget that fits each spot. It
requires no changes to your content model.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Blink.net account details
   and place the widget blocks.

## Where it lives in the admin menu

The settings form sits under **Configuration → Web services → Blink.net**
(`/admin/config/services/blinknet`) and requires the **Administer blinknet**
permission. The donation and subscription blocks are placed from **Structure →
Block layout**.
