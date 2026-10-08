<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Fixtures (content_fixtures) — agent index

A developer **framework for defining content fixtures in code** and loading reproducible
test/demo content, modelled on Symfony's DoctrineFixturesBundle. You write PHP **fixture
classes** registered as services tagged `content_fixture`; each class's `load()` method
programmatically creates entities (nodes, terms, users, …). All fixtures are run, purged, and
listed through **Drush only** — there is no route, controller, form, or permission. Package
`Development`. info.yml name **"Content Fixtures"**, version **3.2.0**. Core
`^8.7.7 || ^9 || ^10 || ^11`. License GPL-2.0+.

Development/test/CI tool. `content-fixtures:load` and `content-fixtures:purge` **delete all
existing content entities first** (each prompts for confirmation, default No) — do not load or
purge fixtures on production.

## What it provides (from source)

- **Fixture contract** `Drupal\content_fixtures\Fixture\FixtureInterface` — a single `load()`
  method. Minimal fixture: implement it and register a service tagged `content_fixture`.
- **Base class** `AbstractFixture` (implements `SharedFixtureInterface`) — adds
  `addReference()` / `setReference()` / `getReference()` / `hasReference()` for sharing created
  objects between fixtures (backed by the `ReferenceRepository` service), plus a protected
  `getRandom()` returning `Drupal\Component\Utility\Random`.
- **Ordering interfaces** (mutually exclusive — implementing both throws):
  - `OrderedFixtureInterface::getOrder()` — integer sort key.
  - `DependentFixtureInterface::getDependencies()` — array of fixture class names loaded before
    this one; the `Loader` topologically sorts them and throws `CircularReferenceException` on a
    cycle.
- **Grouping** `FixtureGroupInterface::getGroups()` — arbitrary group strings; `--groups=a,b`
  filters `list`/`load` to fixtures in those groups.
- **Services** (`content_fixtures.services.yml`):
  - `content_fixtures_loader` → `Loader\Loader` — `service_collector` on tag `content_fixture`
    (calls `addFixture`); dedupes, validates ordering, and sorts fixtures.
  - `content_fixtures_reference_repository` → `Service\ReferenceRepository` — in-memory named
    object store.
  - `content_fixtures_content_purger` → `Purger\ContentPurger` (aliased public as
    `content_fixtures_default_purger`).
- **Drush commands** (`drush.services.yml` → `Commands\ContentFixturesCommands`, tag
  `drush.command`; `@validate-module-enabled content_fixtures`):
  - `content-fixtures:list` (alias `content-fixtures-list`, `--groups`) — lists tagged fixtures
    in execution order; does not touch content.
  - `content-fixtures:load` (alias `content-fixtures-load`, `--groups`) — **purges all content,
    then** calls `load()` on each fixture. Interactive confirm, default No.
  - `content-fixtures:purge` (alias `content-fixtures-purge`) — purges all content only.
    Interactive confirm, default No.
- **Purge semantics** (`ContentPurger::purge()`): loads and deletes every entity of every
  **content** entity type that has an installed schema; the only protected entities are `user`
  with id ≤ 1 (anonymous + user 1). No config entities are touched.

## Sub-module

- **`content_fixtures_example`** (`modules/content_fixtures_example/`) — worked examples of the
  fixture pattern (article fixtures, generating files via an `ImageProvider`, groups, and
  splitting fixtures with shared references / dependencies). Enable it to study, not for
  production.

## No config / no web surface

No `*.routing.yml`, `*.permissions.yml`, controller, or form. No config schema or settings form.
No third-party library dependencies (suggests `joshtronic/php-loremipsum` and `fakerphp/faker`
for authoring fixture data). Requires Drush (`^9 || ^10 || ^11 || ^12 || ^13`).

## Docs

- Human manual guide: [../human-docs/index.md](../human-docs/index.md)
- Task-oriented usage: [../usage.md](../usage.md)
