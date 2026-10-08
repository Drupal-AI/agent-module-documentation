<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Fixtures (data_fixtures) — agent index

A **local-development / testing** framework for generating dummy content. It defines no content
itself: other modules register **generator** services (tag `data_fixtures`, implementing
`Drupal\data_fixtures\Interfaces\Generator`), and **Drush** commands load/unload them. Package
**Development**. Core `^8.9.0 || ^9.0 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.10.
Composer dep: **`fakerphp/faker` ^1.15**. No module dependencies, **no routes, no permissions, no
config**.

- **Writing and registering a generator, the base class helpers, the collector service** →
  [api/generators.md](api/generators.md)
- **The Drush commands and how they run generators** → [drush/commands.md](drush/commands.md)

## What it actually is

- A **service_collector**: `data_fixtures` service = `FixturesManager` (`src/FixturesManager.php`),
  which collects every service tagged `data_fixtures` via `addGenerator()` and sorts them by
  priority (`data_fixtures.services.yml`).
- A **contract**: `Interfaces\Generator` — two methods, `load()` and `unLoad()`. Any class
  implementing it, registered as a tagged service, becomes a fixture.
- Each collected generator is wrapped in `FixturesGenerator` (`src/FixturesGenerator.php`), which
  exposes an **alias** (custom, or the class short-name via reflection) and `prettyPrint()`.
- An optional base class `AbstractGenerator` (`src/AbstractGenerator.php`) wrapping **Faker** with
  helpers: `getLink()`, `getFormattedText()`, `getRandomEntities()`, `getMediaByName()`,
  `unloadEntities()`. Extending it is convenience, not required.
- Drush ^9+ commands in `src/Commands/DataFixturesCommands.php` (`drush.services.yml`); a legacy
  `data_fixtures.drush.inc` provides the same commands for Drush 8-style callbacks.
- Ships sample assets under `assets/` (`images/dummy-media*.jpg`, `attachments/sample.pdf`).
- `hook_help()` in `data_fixtures.module` is the only hook. `Services\DummyGenerator` is
  **`@deprecated`** and not wired into the collector — ignore it for new work.

## Provides

- **Service:** `data_fixtures` (`FixturesManager`), plus the unused `data_fixtures.dummy_generator`.
- **Service tag / extension point:** `data_fixtures` (`call: addGenerator`).
- **Drush commands:** `fixtures:list`, `fixtures:load`, `fixtures:unload`, `fixtures:reload`
  (aliases `fixtures-*`).
- **Base class:** `AbstractGenerator`; **contract:** `Interfaces\Generator`.

## Caveats

- Explicitly **not production-ready** (per README): content is random and the model assumes the DB
  can be truncated. Use on dev / test / CI only.
- `load()`/`unLoad()` are **your** code — generators create and delete real entities; a broad
  `unloadEntities()` condition set can delete more than intended. Scope conditions carefully.
