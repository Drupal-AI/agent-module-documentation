<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Data Fixtures lets developers populate a Drupal site with dummy content by registering service-tagged "generator" classes that a set of Drush commands load and unload on demand.

---

Data Fixtures is a local-development and testing helper. It ships no content, routes, permissions, or configuration of its own; instead it defines a small framework in which any module can declare a fixture *generator* — a PHP class implementing `Drupal\data_fixtures\Interfaces\Generator` (methods `load()` and `unLoad()`) and registered as a service tagged `data_fixtures`. A collector service, `FixturesManager`, gathers every tagged generator, wraps each in a `FixturesGenerator` (which derives an alias from the class short-name), and sorts them by priority. Four Drush commands — `fixtures:list`, `fixtures:load [alias|all]`, `fixtures:unload [alias|all]`, and `fixtures:reload [alias|all]` — then run the generators: load runs in registration/priority order, unload runs in reverse so dependent content is torn down safely. An optional `AbstractGenerator` base class wraps `fakerphp/faker` and provides convenience helpers for building link/formatted-text field values, fetching random existing entities, finding a media entity by its file name, and bulk-deleting entities by type and conditions. The module is deliberately not production-ready — its whole model is that the database can be truncated and content is random — so it is meant for spinning up disposable dev, demo, or CI environments with known, reproducible sample data.

---

- Seed a fresh local Drupal install with dummy nodes, users, taxonomy terms, and media for development.
- Build disposable CI/CD test environments on the fly, with no dependency on production data.
- Give front-end developers ready-made sample content so they never hand-create test nodes.
- Define a per-module generator that creates the content its custom entity type or bundle needs to be testable.
- Register a generator by tagging a service with `data_fixtures` in a module's `*.services.yml`.
- Implement `load()` to create fixtures and `unLoad()` to remove exactly what was created.
- Load every enabled generator at once with `drush fixtures:load all`.
- Load a single generator by its alias, e.g. `drush fixtures:load MyArticleGenerator`.
- Tear down all generated content with `drush fixtures:unload all` (runs in reverse order).
- Rebuild content from scratch in one step with `drush fixtures:reload all` (unload then load).
- List every registered generator and its alias with `drush fixtures:list`.
- Control the order generators run in by setting the service tag `priority` (lower runs first).
- Give a generator a stable custom alias via the tag so command-line targeting is predictable.
- Extend `AbstractGenerator` to get a preconfigured Faker instance for random text, names, dates, etc.
- Generate structured link-field values with `getLink()` (random URL and label when none supplied).
- Produce formatted (long) text field values with a chosen text format via `getFormattedText()`.
- Pick random existing entities of a type (optionally filtered by conditions) with `getRandomEntities()`.
- Attach sample media by looking up a media entity from its image/file filename with `getMediaByName()`.
- Reference the shipped sample assets (`assets/images/*.jpg`, `assets/attachments/sample.pdf`) in fixtures.
- Bulk-delete generated entities by type and conditions in `unLoad()` via `unloadEntities()`.
- Keep team environments consistent by committing generators alongside the config that needs them.
- Demo a feature quickly by loading only the generator relevant to it, then unloading afterward.
- Reset a scratch environment repeatedly during development with `fixtures:reload`.
