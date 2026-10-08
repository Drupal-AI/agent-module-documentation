<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affected By Promotion (affected_by_promotion) — agent index

A tiny Commerce **developer API**: one service that returns a DB query for the entities a
promotion's offer affects. No routes, no UI, no permissions, no config, no submodules.

- **Version dir** `8.x-1.x` (packaged `8.x-1.5`). Core `^8.7.7 || ^9 || ^10 || ^11`.
- **Depends on** `commerce_promotion` (project `drupal/commerce ^2.0|^3.0`).
- **License** GPL-2.0-or-later.

## What it actually is (from source)

- Service `affected_by_promotion.affected_entities_manager` → class
  `Drupal\affected_by_promotion\AffectedEntitiesManager` (`src/AffectedEntitiesManager.php`),
  registered in `affected_by_promotion.services.yml` with **no arguments**.
- Interface `Drupal\affected_by_promotion\SupportsAffectedEntitiesQueryInterface`
  (`src/SupportsAffectedEntitiesQueryInterface.php`) — the extension point an offer plugin
  implements to expose its targeting query.
- That's the whole module: two PHP files plus `.info.yml`, `.services.yml`, `composer.json`,
  and unit tests. No `.module`, no `.routing.yml`, no `.permissions.yml`, no `config/`.

## The API

- [api/affected_entities_manager.md](api/affected_entities_manager.md) — the service's two
  methods, the offer-plugin interface contract, return semantics, and a usage snippet.
