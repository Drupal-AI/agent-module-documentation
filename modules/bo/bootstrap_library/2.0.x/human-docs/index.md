# Bootstrap Library — manual setup guide

**Bootstrap Library** (`bootstrap_library`) registers the **Bootstrap** CSS/JS
framework as a Drupal asset library and attaches it to your pages — with rules for
*which themes* and *which pages* it loads on, and a choice between a locally
installed copy and a pinned CDN version. It is the easy way to add Bootstrap's grid,
components and JavaScript (dropdowns, modals, collapse) to a site whose theme does
not already bundle the framework, without hand‑writing a `libraries.yml` entry in
every custom module.

Once configured, the module does its work through two Drupal hooks on each page
request: it checks your theme rule and your path rule, and if both pass it attaches
one Bootstrap library — a minified local build, a source local build, a
Composer‑installed layout, or a specific version from a CDN. You can load Bootstrap
site‑wide, restrict it to one theme in a multi‑theme site, keep it off admin pages so
it can't clash with Claro/Gin, or limit it to a single marketing landing page and its
children. There is even a `?bootstrap=no` query‑string escape hatch to disable it for
one request while you debug a CSS conflict.

Everything is driven from a single settings form at *Configuration → Development →
Bootstrap Library*. The module supports Drupal 10.3 and 11 and expects the Bootstrap
files themselves to be provided either locally (in `/libraries/bootstrap`), via the
`twbs/bootstrap` Composer package, or from the CDN option in the settings.

This guide is written for a **human** installing and configuring the module through
the admin UI. If you want the terse, token‑cheap reference for an AI coding agent —
every settings key with its exact values, the visibility logic, the four library ids
and the known quirks — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, provide
   the Bootstrap files, and enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   where Bootstrap comes from, which build, and the theme/page visibility rules.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Bootstrap Library**
(`/admin/config/development/bootstrap_library`). Access is governed by core's
**Administer site configuration** permission; the module defines no permission of its
own.

## How to use it

1. Install the module and make the Bootstrap files available (see
   [Installation](installation/index.md)).
2. Open **Configuration → Development → Bootstrap Library** and choose where
   Bootstrap loads from — a **CDN version** or a **local** build (minified, source or
   Composer layout).
3. Set the **theme** and **page** visibility rules so Bootstrap loads exactly where
   you want it (see [Configuration](configuration/index.md)).
4. Save, clear caches, and load a front‑end page to confirm the CSS/JS is attached.

> **Heads‑up:** out of the box the module attaches *nothing* until you configure the
> visibility rules — the shipped default theme rule excludes all themes until you
> pick one. This is covered in detail on the [Configuration](configuration/index.md)
> page.
