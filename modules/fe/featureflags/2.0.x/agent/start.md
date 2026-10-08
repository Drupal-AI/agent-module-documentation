<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feature flags (featureflags) — agent index

Manage named feature flags in Drupal and check them from code, cache, and block visibility.
Version **2.0.4**. Core `^8.8 || ~9.0 || ^10 || ^11`. **No module dependencies.** No `.module`,
no `.install`, no `config/install`, no `*.routing.yml` (routes come from the entity route
provider), no Drush commands.

## What it provides

- **Config entity `featureflag`** (`src/Entity/FeatureFlag.php`, config prefix `flag` →
  config names `featureflags.flag.{id}`). Exports only `name`, `id`, `description` — the flag
  *definition*. The on/off **state is NOT in config**; it lives in the State/key-value store.
- **Service `featureflags.manager`** = `FlagManager` (`src/FlagManager.php`), a subclass of core
  `State` bound to key-value collection `featureflags`. Reads/writes each flag's boolean state.
- **Cache context `featureflags`** = `FeatureFlagContext` (`src/FeatureFlagContext.php`), used as
  `featureflags:{id}` to vary render caching on a flag.
- **Condition plugin `featureflags`** = `FeatureFlagStatus`
  (`src/Plugin/Condition/FeatureFlagStatus.php`) — block visibility / condition gating, AND/OR
  over several flags.
- **Permission** `administer featureflag entities` (`featureflags.permissions.yml`) — the entity's
  `admin_permission`; gates the whole admin UI.

## Admin surface (entity route provider, `AdminHtmlRouteProvider`)

- Collection: `/admin/structure/feature-flags` (menu link under *Structure*).
- Add: `/admin/structure/feature-flags/add` (action link on the collection).
- Edit: `/admin/structure/feature-flags/manage/{featureflag}`.
- Delete: `/admin/structure/feature-flags/manage/{featureflag}/delete`.

All four require `administer featureflag entities`. Note: the drupal.org project page still cites
the old 1.x path `admin/config/development/featureflags`; on 2.x it is `/admin/structure/feature-flags`.

## Solution docs

- **The config entity, admin forms, routes, permission, and where state is stored** →
  [config/feature-flag-entity.md](config/feature-flag-entity.md)
- **Checking flags from code: the manager service, the static `FeatureFlag` API, and the cache
  context** → [api/flag-checks.md](api/flag-checks.md)
- **The `featureflags` condition plugin (block visibility, AND/OR)** →
  [plugins/condition.md](plugins/condition.md)

## Key classes

`Entity/FeatureFlag`, `Entity/FeatureFlagInterface`, `FlagManager`, `FeatureFlagContext`,
`Form/FeatureFlagForm`, `EntityHandlers/FeatureFlagListBuilder`,
`Plugin/Condition/FeatureFlagStatus`.
