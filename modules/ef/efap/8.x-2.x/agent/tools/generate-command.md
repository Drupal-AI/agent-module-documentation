<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `generate:efap` scaffolder (Drupal Console)

Optional helper that scaffolds an extra-field plugin class. It is a **Drupal Console** command, not
Drush, and depends on Drupal Console being installed (that project is effectively unmaintained on
modern Drupal, so the command may not run — writing the plugin by hand is equally valid; see
[../plugins/extra-field.md](../plugins/extra-field.md)).

## Wiring

`console.services.yml` registers two services with Drupal Console tags:

- `efap.command.generate` → `src/GenerateCommand.php` (tag `drupal.command`).
- `efap.generator` → `src/Generator.php` (tag `drupal.generator`).

## `GenerateCommand` (`src/GenerateCommand.php`)

- `configure()` sets the command name **`generate:efap`**.
- `execute()` interactively asks: target module; class name (default `DefaultExtraField`, validated via
  `Validator::validateClassName`); entity type (`choiceNoList` over `getEntityTypes()`, default
  `node`); bundle (`choiceNoList` over `getBundles()`); the field label; the field id (default derived
  as `createMachineName(module . '__' . label)`); the field description; and any services to inject
  (`servicesQuestion()` / `buildServices()`).
- It calls `$this->generator->generate(...)` then queues `cache:rebuild` (`cache => discovery`) via
  `chainQueue`.
- Helpers: `getEntityTypes()` lists `entity_type.manager` definition ids (sorted);
  `getBundles($entityType)` returns keys from `entity_type.bundle.info`.

## `Generator` (`src/Generator.php`)

`Generator extends \Drupal\Console\Core\Generator\Generator`. Its `generate()` renders
`templates/ExtraField.php.twig` to
`<module>/src/Plugin/ExtraField/<EntityFolder>/<Class>.php`, where `<EntityFolder>` is the entity type
converted to UpperCamelCase (`underscoreToCamelCase` + `anyCaseToUcFirst`). Template parameters:
`module, class, entityType, folder, bundle, id, label, description, services`.

## The template (`templates/ExtraField.php.twig`)

Extends Drupal Console's `base/class.php.twig`. Produces a class that `extends ExtraFieldBase`, adds
the `@ExtraField(id, label, description)` annotation, and emits `info()` (populating
`$field[entityType][bundle]['display'][id]` with label/description/`weight=0`/`visible=FALSE`) and a
`view()` that calls `parent::view(...)`. When services were chosen it also implements
`ContainerFactoryPluginInterface` and generates the matching `__construct()`/`create()` pair.

Net effect: the generated file is exactly the hand-written pattern in
[../plugins/extra-field.md](../plugins/extra-field.md); the command only saves typing.
