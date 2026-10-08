<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Geo Update (localgov_geo_update) — agent index

**Hidden** bridging submodule of [localgov_geo](../../../../2.1.x/agent/start.md) for sites
upgrading from LocalGov Geo 1.x (own entity) to 2.x (entity provided by `geo_entity`).

Key facts:
- `hidden: true` in `localgov_geo_update.info.yml` — it does not appear at `/admin/modules`.
  Enable it explicitly if an upgrade needs it:
  `drush en localgov_geo_update -y`.
- Depends on `localgov_geo`.
- Purpose is the upgrade path only; **new sites should not enable it**. Installing `localgov_geo`
  (with `geo_entity`) already gives the current structure.
- The parent module's `localgov_geo_update_last_removed()` returns **8810** — all pre-Drupal-10
  update hooks were dropped because their work now lives in `geo_entity`. A site whose schema
  version is below that cannot upgrade directly; step through an intermediate release first.
- After `drush updatedb` completes and geo data is verified, the module can be uninstalled.
