<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Factory Lollipop (factory_lollipop) — agent index

**Factory-pattern library for building valid, short-lived Drupal test data** from reusable named
blueprints. A developer registers blueprints on the `FixtureFactory` service and calls
`create($name, $overrides)` from PHPUnit tests or developer/CLI code; a tagged-service chain resolves
each blueprint's data `type` to a `FactoryType` that creates and persists the entity. Package
`Development`. License GPL-2.0-or-later. Installed version **1.2.5** (version dir `1.2.x`).
Core `^10.5 || ^11`.

## Dependencies

- `drupal:user` (only module dependency).
- No Composer runtime `require` (composer.json declares only `require-dev`: `drupal/paragraphs`,
  `drupal/coder`, `drupal/pathauto`). Install as a dev dependency:
  `composer require --dev drupal/factory_lollipop`.

## What it provides (from source)

- **Service `factory_lollipop.fixture_factory`** = `Drupal\factory_lollipop\FixtureFactory` — the
  developer-facing API (`define`, `create`, `association`, `sequence`, `loadAllDefinitions`, …).
  → [api/fixture-factory.md](api/fixture-factory.md)
- **Two chain resolvers** (tagged `service_collector`): `ChainFactoryTypeResolver`
  (`factory_lollipop.factory_type.chain_resolver`, collects `factory_lollipop.factory_type_resolver`)
  and `ChainFactoryResolver` (`factory_lollipop.factory.chain_resolver`, collects
  `factory_lollipop.factory_resolver`). → [api/factory-types.md](api/factory-types.md)
- **Extension points (tagged services, not Drupal Plugin API):** `FactoryTypeInterface` implementations
  create one data type each; `FactoryInterface` implementations register named blueprints. Add/override
  either by tagging a service with a priority. → [api/factory-types.md](api/factory-types.md),
  [api/defining-factories.md](api/defining-factories.md)
- **13 built-in FactoryTypes** (`src/FactoryType/*`), type string → class: `node type` → `NodeTypeFactoryType`,
  `node` → `NodeFactoryType`, `entity field` → `EntityFieldFactoryType`, `entity reference field` →
  `EntityFieldEntityReferenceFactoryType`, `vocabulary` → `VocabularyFactoryType`, `taxonomy term` →
  `TaxonomyTermFactoryType`, `role` → `RoleFactoryType`, `user` → `UserFactoryType`, `menu` →
  `MenuFactoryType`, `menu link` → `MenuLinkFactoryType`, `file` → `FileFactoryType`, `media type` →
  `MediaTypeFactoryType`, `media` → `MediaFactoryType`. → [api/factory-types.md](api/factory-types.md)
- **Three traits** (`src/Traits/*`): `RandomGeneratorTrait`, `UserCreationTrait`,
  `EntityReferenceTestTrait`. → [api/traits.md](api/traits.md)
- **Submodule `factory_lollipop_paragraphs`** adds `paragraph` + `paragraph type` FactoryTypes
  (requires `paragraphs`). → [../modules/factory_lollipop_paragraphs/1.2.x/agent/start.md](../modules/factory_lollipop_paragraphs/1.2.x/agent/start.md)

## What it does NOT provide

No routes, no controllers, no forms, no permissions, no `*.links.*`, no config objects, **no config
schema**, no `config/install`, no `.install`, no entities, no Drush, no cron/event/entity runtime hooks.
The only `.module` code is `hook_help()` (renders `README.md` on the module's help page). `configure`
is null. It is a developer/test-only library, invoked on demand from trusted test/CLI code — it has no
HTTP surface and no access-control role.

## Install / operate

1. `composer require --dev drupal/factory_lollipop`.
2. `drush en factory_lollipop -y` (enable `factory_lollipop_paragraphs` too if you need paragraph factories).
3. In tests, get the service (`$this->container->get('factory_lollipop.fixture_factory')`), register
   blueprints (directly with `define()`, or via `Factory` classes loaded through
   `loadAllDefinitions()`), then call `create()`. See the API docs above.
