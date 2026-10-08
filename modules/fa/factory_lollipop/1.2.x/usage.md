<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Factory Lollipop is a developer/test library that uses the factory pattern to build valid, short-lived Drupal test data (entities, bundles, fields, users, roles, menus, files, media) from reusable named blueprints.

---

Install it as a dev dependency (`composer require --dev drupal/factory_lollipop`) and use it from PHPUnit kernel/functional tests or developer/CLI code. You define small Factory classes (implementing `FactoryInterface`) that register named blueprints on the `FixtureFactory` service, then call `FixtureFactory::create($name, $overrides)` to instantiate and persist a real Drupal object with sensible random defaults. Each blueprint names a data `type` string; a tagged-service chain resolver dispatches that type to the first matching `FactoryType` (`FactoryTypeInterface`), so blueprints stay declarative while creation logic lives in reusable, overridable type plugins. Built-in FactoryTypes cover node types, nodes, fields, entity-reference fields, vocabularies, taxonomy terms, roles, users, menus, menu links, files, media types and media; the `factory_lollipop_paragraphs` submodule adds paragraphs and paragraph types. Because everything is wired as tagged services, projects can decorate or replace any type and register their own factories. Helper traits (`RandomGeneratorTrait`, `UserCreationTrait`, `EntityReferenceTestTrait`) supply random values and user/role/reference-field helpers. The module has no routes, permissions, forms, config or runtime hooks — it runs only when your test/CLI code calls it.

---

- Generate valid Drupal nodes on demand inside a PHPUnit kernel test.
- Create a node type (content type) blueprint and reuse it across a whole test suite.
- Add custom fields and entity-reference fields to a bundle for testing.
- Build a vocabulary and taxonomy terms to test tagging/categorisation logic.
- Create test users with specific roles, permissions, mail and status.
- Create roles with a given permission set to test access-control logic.
- Create menus and menu links to test navigation or menu-based features.
- Generate file entities (random `.txt` or copied from a source path) for file-field tests.
- Create media types and media entities for media-field and media-library tests.
- Create paragraphs and paragraph types (via `factory_lollipop_paragraphs`) for layout/content tests.
- Register named blueprints once and instantiate many variants with per-call overrides.
- Cascade related objects with `FixtureFactory::association()` (e.g. a node that auto-creates its node type).
- Produce unique, incrementing values (usernames, machine names) with `FixtureFactory::sequence()`.
- Replace fixed SQL/YAML fixtures with programmatic, customisable factories.
- Test a custom or contrib module against realistic content scenarios that a config-sync/profile would normally provide.
- Override or decorate a built-in FactoryType (e.g. change how nodes are created) via a higher-priority tagged service.
- Add a project-specific FactoryType for a custom entity type by tagging a new service.
- Seed data in test `setUp()` and clean up in `tearDown()`.
- Use random data helpers (`randomString`, `randomMachineName`, `randomObject`) to avoid hard-coded fixtures.
- Assign default option closures that are evaluated lazily at create time.
- Bootstrap coherent multi-entity scenarios (content type + fields + nodes + terms) for a contrib module's test suite.
- Populate a scratch/dev site with sample content from a Drush/PHP script.
- Load all or a subset of registered factory definitions with `loadAllDefinitions()` / `loadDefinitions()`.
- Inspect currently registered blueprints with `getDefinitions()` / `getDefinition()`.
