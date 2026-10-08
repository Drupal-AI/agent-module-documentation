<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Awareness (awareness) — agent index

Pure developer-API module: a library of ~47 single-purpose PHP traits (namespace `Drupal\awareness\*`) that each add a protected getter method returning a common Drupal core service through a static `\Drupal::service()` call, plus a Drush code generator to create more. No routes, permissions, config, schema, entities, plugins, services.yml, blocks, or UI.

- Machine name: `awareness`; version dir `2.0.x` (installed 2.0.8).
- `core_version_requirement: ^10.3 || ^11`. License GPL-2.0-or-later.
- Dependency: `drupal:file` (only used by `FileRepositoryAwareTrait`).
- Composer: `drupal/awareness`, no extra `require`.

What it provides:
- ~47 traits, one per service, e.g. `Entity/EntityTypeManagerAwareTrait::getEntityTypeManager()` and `getEntityQuery()`, `Config/ConfigFactoryAwareTrait::getConfig()`/`getEditableConfig()`, `Http/HttpClientAwareTrait::getHttpClient()`, `Database/DatabaseAwareTrait::getDatabase()`, `Cache/CacheFactoryAwareTrait::getCacheBin()`, plus queue, mail, tempstore, keyvalue, file, render, token, uuid, state, settings, session, routing, etc. Each trait body is just `return \Drupal::service('<id>')` (or a `\Drupal::` helper).
- A Drush generator: `src/Drush/Generators/AwarenessTraitGenerator.php` (`#[Generator(name: 'awareness:trait', aliases: ['aware'])]`) + template `templates/generator/awareness-trait.twig`. Run `drush generate awareness:trait`.
- A kernel test `tests/src/Kernel/AwarenessKernelTest.php` exercising every trait (useful as a usage catalogue of method names).

Usage model: depend on the module, then `use Drupal\awareness\<Area>\<X>AwareTrait;` in your class and call the getter. Convenience over constructor DI; not a DI replacement.

Solution docs:
- [agent/api/traits.md](api/traits.md) — full trait/method catalogue, namespaces, and how to consume them.
- [agent/api/generator.md](api/generator.md) — the `awareness:trait` Drush generator and its template.
