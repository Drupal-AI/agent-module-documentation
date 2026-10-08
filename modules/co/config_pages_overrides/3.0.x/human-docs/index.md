# Config Pages Overrides — manual setup guide

**Config Pages Overrides** (`config_pages_overrides`) lets a value entered on a
[Config Pages](https://www.drupal.org/project/config_pages) field override any *simple*
configuration value — for example, using a text field on a config page to override the site
name (`system.site:name`). Normally, letting an editor change a piece of configuration like
that would mean a developer hand‑writing a custom override service for each setting. This
module removes that chore: you map a config‑page field to a target configuration item
through the UI, and the override happens automatically.

Under the hood it registers a single configuration‑factory override. Whenever configuration
is loaded, it reads the mappings you stored on each Config Pages **type**, pulls the current
value from the matching Config Page, optionally wraps it with a prefix/suffix, casts it to
the target's schema type (so a checkbox becomes a real boolean, a number a real integer),
and injects it into the configuration. Because this runs inside the config factory, editing
a Config Page instantly re‑shapes the overridden configuration site‑wide.

It depends on the **Config Pages** module and requires Drupal **11.1+**. There is no global
settings page — the mappings live on each Config Pages *type*, and the whole feature is
gated by that type's update access, so only users who can administer Config Pages types can
create or change overrides. Note that this project is **not covered by Drupal's security
advisory policy**, so weigh that against your site's risk tolerance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (Config
   Pages first).
2. [Configuration](configuration/index.md) — map a config‑page field to a target
   configuration item, field by field.

## Where it lives in the admin menu

The module adds no standalone settings page. Instead, on a Config Pages **type** you get a
**Config Overrides** tab at
`/admin/structure/config_pages/types/manage/{config_pages_type}/overrides` (with an
*add* form at `.../overrides-add`). Both require the ability to update that Config Pages
type. The mappings you create there are stored on the type entity itself.
