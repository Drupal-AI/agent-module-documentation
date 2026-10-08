<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Realistic Dummy Content (realistic_dummy_content) — agent index

Replaces the placeholder output of Devel's `devel_generate` (lorem-ipsum text and grey colour
blocks) with **realistic** values — portraits, stock photos, real sentences — read from a directory
of files you supply. Nothing runs on the web: the mechanism is a single `hook_entity_presave`
implementation in the **`realistic_dummy_content_api`** submodule. When any entity is saved with the
`devel_generate` marker set on it, the API module walks every enabled module for a directory
`MODULE/realistic_dummy_content/fields/{entity_type}/{bundle}/{field_name}/`, picks a candidate file
(random by default), and writes its contents into the matching field/property before the entity is
persisted. The project ships **two** modules: `realistic_dummy_content_api` (the reusable
mechanism — hooks, drush, the file-convention reader) and `realistic_dummy_content` (a thin example
that depends on the API module and carries the bundled article images/text, user portraits, and an
example recipe under its own `realistic_dummy_content/` directory).

Content generation still comes from `devel_generate`; this module only post-processes the generated
entities. A **recipe** system (a Drush command plus a `RealisticDummyContentRecipe` subclass) lets
you script fixed sequences of entities (e.g. 4 pages then 10 articles). To customise the content,
you do not write PHP — you reproduce the `realistic_dummy_content/fields/...` directory layout in
your own module. Custom **field types** are supported by implementing the manipulator alter hook.

- Depends on: its own bundled submodule `realistic_dummy_content:realistic_dummy_content_api`
  (the parent module's only declared dependency). **Needs Devel** (`devel_generate`) at runtime to
  actually create users/nodes — declared only as `test_dependencies`, so install it yourself.
- Core: `^10 || ^11`. PHP `8.x`. Package: `Development`. Tag: `developer`.
  Version **4.0.0-beta1** (beta). Its info.yml description says *"Do not enable on production sites."*
- **No** settings page / `configure` route, **no** routes, **no** controllers, **no** forms, **no**
  DIC services (only a Drush command service), **no** permissions, **no** plugin types, **no** field
  widgets/formatters, **no** config schema. One config default (`realistic_dummy_content_api_rand`).
- Provides one **Drush** command and three integrator **hooks**.

## What you'd do → where

- **Supply your own realistic content / understand the file-directory convention, dummy detection,
  the entity_presave flow, the config toggle, and add support for a custom field type** →
  [api/extend.md](api/extend.md)
- **Generate content from the CLI / write a sequenced "recipe" of entities** →
  [drush/generate.md](drush/generate.md)

## Key facts (real machine names)

- Modules: `realistic_dummy_content` (parent, example data), `realistic_dummy_content_api` (mechanism).
- Namespaces: `Drupal\realistic_dummy_content_api\` → `api/src/`; `Drupal\realistic_dummy_content\`
  → `src/` (the parent `src/` is empty — parent is data only).
- Hook implemented: `hook_entity_presave` → `realistic_dummy_content_api_entity_presave()` →
  `Framework::instance()->hookEntityPresave($entity)` (`api/src/Framework/Drupal8.php:23`).
- Integrator hooks (defined in `api/realistic_dummy_content_api.api.php`):
  `hook_realistic_dummy_content_api_dummy($entity, $type)`,
  `hook_realistic_dummy_content_api_class($entity, $type, $filter)`,
  `hook_realistic_dummy_content_attribute_manipulator_alter(&$class, &$info)`.
- Default dummy test: `isset($entity->devel_generate)` (`Drupal8::entityIsDummy`).
- Default modifier class: `…\includes\RealisticDummyContentFieldModifier`. Field-type manipulators:
  `RealisticDummyContentTextWithSummaryField` (text_with_summary),
  `RealisticDummyContentTermReferenceField` (taxonomy_term_reference / entity_reference→taxonomy),
  `RealisticDummyContentImageField` (image); default text/value:
  `RealisticDummyContentTextProperty` / `RealisticDummyContentValueField`.
- File convention: `MODULE/realistic_dummy_content/fields/{entity_type}/{bundle}/{field_name}/`.
  Value files: `*.txt` (text), `*.gif|*.png|*.jpg` (image). Metadata files:
  `<name>.<ext>.<attr>.txt` — e.g. `ipsum.txt.format.txt` (text format), `photo.jpg.alt.txt` (alt).
  `README*` files in these dirs are ignored.
- Drush command: `realistic_dummy_content_api:generate-realistic` (aliases `generate-realistic`,
  `grc`) — `api/src/DrushCommands/RealisticDummyContentDrushCommands.php`; registered via
  `drush.services.yml` (service `realistic_dummy_content_api.drush_commands`).
- Recipes: subclass `…\includes\RealisticDummyContentRecipe` named
  `{module}_realistic_dummy_content_recipe` in
  `{module}/realistic_dummy_content/recipe/{module}.recipe.inc`; implement `_Run_()`, call
  `$this->NewEntities($type, $bundle, $count, ['kill' => TRUE])`. Only `user`/`node` supported.
- Config: `realistic_dummy_content_api.realistic_dummy_content_api_rand` (default `1` = random;
  set falsy for deterministic/sequential numbering). Constants `REALISTIC_DUMMY_CONTENT_API_RANDOM`
  (TRUE), `REALISTIC_DUMMY_CONTENT_API_SEQUENTIAL` (FALSE).
