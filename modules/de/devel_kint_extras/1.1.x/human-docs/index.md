# Devel Kint Extras — manual setup guide

> **This module is deprecated and obsolete — do not install it.** Its `.info.yml`
> marks it `lifecycle: obsolete`, and running `drush en devel_kint_extras` on
> Drupal 11 fails with the error *"module 'devel_kint_extras' is obsolete."* Use the
> standalone [Kint module](https://www.drupal.org/project/kint) instead. See the
> [deprecation notice](https://www.drupal.org/node/3549864) for details.

**Devel Kint Extras** (`devel_kint_extras`) was a small development‑only add‑on for
the **Devel** module. When you dumped a variable with Kint (via `kint()` or `ksm()`),
it enhanced the output so the dump also showed an object's available **methods** and
**static properties** — handy when exploring an unfamiliar class while debugging.

It worked by replacing Devel's built‑in `kint` dumper with its own `KintExtended`
dumper and tuning Kint for more readable output (removing the iterator plugin,
disabling rich‑renderer folding, and trimming the service container from dumps).

The module no longer functions because **Devel removed its Kint integration in
version 5.4.0**, so there is no Devel `kint` dumper left for this module to extend.
The maintainers direct everyone to the standalone Kint module, and any feature
requests for this behavior should be filed in that project's issue queue.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — why it cannot be enabled, and what to
   install instead.

## Where it lives in the admin menu

Nowhere. It never had a settings page, and on Drupal 9.5+/10/11 it cannot be enabled
at all.

## What to use instead

Install the standalone **Kint** module for Kint‑based variable dumping:

```bash
composer require drupal/kint -W
drush en kint -y
```

If you previously had Devel Kint Extras selected as your dumper, its update hook
resets Devel's dumper setting back to the plain `kint` value on uninstall.
