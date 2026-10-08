<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NoUiSlider (nouislider_better_exposed_filters) — agent index

**Adds a noUiSlider slider widget to Better Exposed Filters for multi-value `select` exposed filters in Views.**

- **Version:** 1.0.x  •  core: `^9 || ^10 || ^11`  (installed release 1.0.0-alpha2)
- **Depends on:** better_exposed_filters; plus the noUiSlider JS library (>=15.7.x) in `/libraries/nouislider`.
- **Plugin:** `Drupal\nouislider_better_exposed_filters\Plugin\better_exposed_filters\filter\nouislider` (id `bef_nouislider`). One setting: **Pips mode** (`range` | `steps`).
- **Libraries:** `nouislider` (bundled), `nouislider-init` (`js/nouislider.js`, deps core/drupal, core/once).
- **No routes, permissions, services, or config entities.** Configured entirely inside a View's Better Exposed Filters settings; only acts on `#multiple` `select` filters.
- **Security:** purely a client-side exposed-filter widget; no server endpoints, no access logic of its own — inherits the host View's access. No security findings.
