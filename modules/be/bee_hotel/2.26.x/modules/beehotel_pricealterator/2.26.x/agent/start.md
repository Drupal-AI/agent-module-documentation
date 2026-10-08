<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel Price Alterator (beehotel_pricealterator) — agent index

Defines the **PriceAlterator plugin type** + manager and the base machinery for Bee Hotel dynamic
pricing. Dependency: `beehotel_utils`. Core `^9.4 || ^10.2 || ^11`. Provides the permission
**`admin pricealterator`**.

## What it provides (from source)

- **Plugin type** `PriceAlterator` — annotation `src/Annotation/PriceAlterator.php`
  (`id`, `description`, `type`, `status`, `weight`, `alteration`, `data`), interface
  `PriceAlteratorInterface::alter(array $data, array $pricetable): array`, base class
  `PriceAlteratorBase`, manager `PriceAlteratorPluginManager` (service
  **`plugin.manager.beehotel.pricealterator`**, scans `Plugin/PriceAlterator`).
- **Services** (`.services.yml`): `beehotel_pricealterator.alter` (`Alter`) runs the per-night
  chain; `beehotel_pricealterator.prealter` (`PreAlter`) builds the base table + season;
  `beehotel_pricealterator.util` (`Util`).
- **Base plugins**: `Plugin/PriceAlterator/GetSeason` (also a config form) and
  `Plugin/PriceAlterator/PriceFromBaseTable`.
- **Routes** (`.routing.yml`): `/node/{node}/basepricetable` (`UnitBasePriceTable` form,
  perm `admin pricealterator`), `/admin/beehotel/pricealterator/alterators` (`AlteratorsList`,
  perm `administer bee_hotel`), `/admin/beehotel/pricealterator/alterators/getseason`
  (`GetSeason` form). Season JSON lives in config
  `beehotel_pricealterator.pricealterator.GetSeason.settings`.
- **Hooks** (`.module`): adds a *Base Table* local task on unit nodes (for
  `administer bee_hotel`), attaches season data to `drupalSettings`, breadcrumb/theme glue.

## Solution docs

- The plugin API, the Alter/PreAlter chain, base tables and how to add an alterator →
  [plugins/alterator-api.md](plugins/alterator-api.md)

Concrete alterator plugins ship in the sibling **beehotel_pricealterators** module.
