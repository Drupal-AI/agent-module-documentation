<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Panther — agent index

Integrates **Symfony Panther** for real-browser (Chrome/Selenium via WebDriver) testing and
web scraping of Drupal. Version **2.0.0**. Core `^10 || ^11`. Requires `drupal/drupal-driver ^3`
and `symfony/panther ^2.2`. Ships a `panther_examples` submodule.

Developer/testing infrastructure — **dev/CI only**, not for production. No routes, no permissions,
no config UI, no plugins, no Drush. All setup is env vars + a service-container parameter block.

- **Set it up (env vars + `panther` service params):** [configure/panther.md](configure/panther.md)
- **Write a test (base class + trait helpers/assertions):** [api/panther.md](api/panther.md)

## 2.0.0 changes vs 1.x (new major)
- **BREAKING:** now requires `drupal/drupal-driver ^3.0`; `EntityManager` ported from the
  `\stdClass` driver API to the `EntityStubInterface` value-object contract. The public entity
  helpers still take/return `\stdClass`, so test code using only them needs no change.
- `PantherTestCase` is now **abstract**; its `EntityManager` is built with the entity type
  manager + menu cache + cache-tags invalidator (was the user storage).
- Added a PHPUnit-style Panther result summary (custom extension) and a distinct symbol for
  tests reported *incomplete*; incomplete tests are marked incomplete rather than failed.
- New settings `accessibility_reports_dir` and `dump_accessibility_reports`.
- See the module's `UPGRADING.md` for the manual dependency step.
