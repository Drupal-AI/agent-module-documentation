# Material Design Bootstrap (MDBootstrap) — manual setup guide

**Material Design Bootstrap** (`mdbootstrap`) integrates the **MDBootstrap** UI kit — a
Material Design component library for Bootstrap 4 and 5 — into Drupal. It gives your site
MDBootstrap's forms, cards, buttons and hundreds of other components with a Material Design
look, and it does this through the [Bootstrap UI](https://www.drupal.org/project/bootstrap_ui)
module: MDBootstrap plugs into Bootstrap UI as an alternative library, so you switch your
site from plain Bootstrap to MDBootstrap from Bootstrap UI's settings.

It is a **theming** feature — it provides front‑end assets and components and has no content
role beyond its own permission. It supports both the free and Pro versions of MDBootstrap
and both the v4 and v5 lines, and offers choices such as loading via CDN or from local
library files, minified or not, dark mode, RTL support, and restricting where the assets
load. Note that MDBootstrap is a third‑party product — respect its license and usage terms
for the version you deploy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and Bootstrap UI with
   Composer, add the MDBootstrap library, and switch Bootstrap UI over to it.

MDBootstrap does not add its own top‑level settings form; you configure it from the
**Bootstrap UI** settings page, described under "How to use it" below.

## Where it lives in the admin menu

The relevant settings live on the **Bootstrap UI** configuration page at
**Administration → Configuration → Bootstrap UI**. That is where you switch the active
**Library** from Bootstrap to **MDBootstrap** and choose how the assets load (CDN vs local,
minified vs not, dark mode, RTL, load restrictions).

## How to use it

1. Install and enable the module and its Bootstrap UI dependency, and place the MDBootstrap
   library files — see [Installation](installation/index.md).
2. Go to **Administration → Configuration → Bootstrap UI**.
3. Switch the **Library** option from **Bootstrap** to **MDBootstrap** so the Material
   Design UI kit is used across the site.
4. Choose your loading options — CDN or local library, minified or non‑minified, dark or
   light mode, RTL support, and any file/theme/path restrictions you want.
5. **Save the configuration.** Your site now renders with MDBootstrap's Material Design
   components.
