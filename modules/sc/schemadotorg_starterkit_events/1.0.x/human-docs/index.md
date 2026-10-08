# Schema.org Starter Kit: Events — manual setup guide

**Schema.org Starter Kit: Events** (`schemadotorg_starterkit_events`) is a ready‑made
setup that creates an **Event** content type mapped to Schema.org, built on the
**Schema.org Blueprints** system. Enabling it gives your site standards‑aligned
events out of the box: the content type and its fields, date handling via **Smart
Date**, listing views, and some default sample content — all wired up so events
carry Schema.org structured data without you building the model by hand.

It is a site‑building starter kit rather than a runtime feature: when you enable it,
it installs configuration (a content type, views, and default content) that then
behaves like anything else on your site and follows normal access rules. It has no
access‑control role of its own. It depends on **Schema.org Blueprints**
(`schemadotorg`), **Smart Date** (`smart_date`), and core **Views**, and supports
Drupal 10.3+ and 11.

> **Deprecated:** this project is deprecated and no longer maintained. Starter Kits
> are no longer the recommended way to set up Drupal sites and features — **use
> Drupal Recipes instead** (see the Schema.org Recipes sandbox for an example).
> Existing installations are not uninstalled automatically; keep using them at your
> own risk while you migrate to Recipes. For new sites, prefer a Recipe.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   starter kit to scaffold the Event content type.

## How to use it

Because it is a starter kit, the intended way to use it is simply to **enable it on
a fresh or evaluation site**. On enable it scaffolds the Event content type, its
fields, Smart Date configuration, views, and default content. From there you manage
events like any other content type — the Schema.org mapping is already in place, so
event pages emit the matching structured data. There is no dedicated settings form.
