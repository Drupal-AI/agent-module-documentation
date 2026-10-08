<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Socrates (openy_socrates) — agent index

A **middleware facade service** (`socrates`, class `OpenySocratesFacade`) for the Open Y / YMCA
Website Services distribution. It is an OOP take on the Strategy pattern: other modules tag their
services as `openy_data_service`, each declaring which method names it answers; the facade routes an
arbitrary method call to the highest-**priority** service that registered that method. Consumers call
`\Drupal::service('socrates')->someMethod(...)` and never depend on the concrete provider, so a
provider can be swapped or absent without hard dependencies. Wiring happens at container-compile time
in `OpenySocratesCompilerPass` (registered by `OpenySocratesServiceProvider`), which finds the tagged
services, verifies each implements the right interface, and injects them into the facade via
`collectDataServices()` / `collectCronServices()`.

A second, independent mechanism rides along: services tagged `openy_cron_service` (implementing
`OpenyCronServiceInterface`) are run by `socrates->cron()` on a per-service **periodicity** (seconds),
tracked in Drupal State — an alternative to `hook_cron` that Open Y triggers with
`drush ev '\Drupal::service("socrates")->cron();'`. The module ships two demo providers
(`ExampleSocratesDataService`, `ExampleSocratesCronService`) and a helper `OpenyRepositoryTrait` for
chunked entity deletion. There are **no routes, no controllers, no forms, no permissions, no settings
page, no external calls** — it is pure architecture, exercised entirely from PHP.

- Depends on: nothing (`dependencies` empty). Optional context: it only earns its keep inside Open Y.
- Core: `^10 || ^11`. Package: `YMCA Website Services`. Version `1.1.0`.
- No `configure` route, **no permissions, no drush commands, no config schema, no Drupal plugin
  types**. Its extension points are **service tags**, not the plugin API.
- Submodule `openy_theme_override` (separate module, same package): a `hook_theme_registry_alter`
  that lets a module ship template overrides under its own `themes/<theme_machine_name>/` folders and
  have them win over the theme's. Enable it separately; it has no PHP API of its own. Not documented
  as a child dir here.

## What you'd do → where

- **Call the facade / understand `__call` dispatch, priority resolution and the exception** →
  [api/facade.md](api/facade.md)
- **Register a service so its methods are reachable through `socrates` (tag + interface)** →
  [api/data-services.md](api/data-services.md)
- **Register a periodic task and run the Socrates cron runner** → [api/cron.md](api/cron.md)

## Key facts (real machine names)

- Service id: `socrates` → `Drupal\openy_socrates\OpenySocratesFacade` (one arg: `@state`). Magic
  `@method mixed getLocationLongtitude(array $args)` / `getLocationLatitude(array $args)` are only
  doc hints — the class defines no such methods; they resolve through tagged providers.
- Demo service ids: `example_socrates_data_service` (`ExampleSocratesDataService`, tag
  `openy_data_service` priority `1000`), `example_socrates_cron_service`
  (`ExampleSocratesCronService`, tag `openy_cron_service` periodicity `86400`).
- Service tags: `openy_data_service` (attribute `priority`, default `0`), `openy_cron_service`
  (attribute `periodicity`, seconds, default `0`).
- Interfaces to implement: `OpenyDataServiceInterface::addDataServices(array $services)` (returns the
  list of method names the service exposes), `OpenyCronServiceInterface::runCronServices()`.
- Facade methods: `__call($name, array $arguments)`, `collectDataServices(array $services)`,
  `collectCronServices(array $services)`, `cron()`.
- Compiler wiring: `OpenySocratesCompilerPass` (consts `OPENYINTERFACE`, `OPENY_CRON_INTERFACE`),
  registered by `OpenySocratesServiceProvider::register()`.
- Exception: `Drupal\openy_socrates\OpenySocratesException` (extends `\Exception`) — thrown for an
  unknown method or a tagged service missing the required interface.
- Trait: `OpenyRepositoryTrait::removeAllByChunks(EntityStorageInterface $storage, array $ids,
  int $chunkSize = 10)`.
- State keys: `openy_cron_<serviceId>` (last-run request time per cron service); logger channels
  `openy_cron` (start/finish + execution time) and `test` (the demo cron service).
- Submodule: `openy_theme_override` (`hook_theme_registry_alter`).
