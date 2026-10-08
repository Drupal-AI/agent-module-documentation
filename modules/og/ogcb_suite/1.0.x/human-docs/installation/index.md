# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`); built for Drupal 11.
- The **Open Government Community Builder (OGCB)** content model. OGCB Suite assumes
  OGCB's group types, node bundles, view modes, and configuration are present — it is
  **not intended for a standalone Drupal site**, and is normally installed as part of
  the OGCB recipe/starter kit.

Individual sub‑modules pull in their own dependencies (for example DANSE and Push
Framework for OGCB Notification, Search API and Facets for OGCB Search, and the
Private Message module for OGCB Private Messages) — Composer resolves those when you
require the suite.

> **Pre‑release:** the current release is **1.0.0‑alpha2**. Treat it as pre‑release.

## Install with Composer

The normal way to get OGCB Suite is by building a site from the OGCB recipe/starter
kit, which installs it for you. To add it directly, from the project root:

```bash
composer require drupal/ogcb_suite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ogcb_suite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module and then the sub‑modules you need:

```bash
drush en ogcb_suite -y
```

Then enable individual sub‑modules as required, for example:

```bash
drush en ogcb_group ogcb_notification ogcb_search -y
```

## Verify it worked

Because the suite depends on OGCB's content model, the meaningful check is that the
sub‑modules you enabled light up their features on a site built from OGCB — for
example the group dashboard from OGCB Group, or the header search block from OGCB
Search. See the [guide overview](../index.md) for what each sub‑module provides.
