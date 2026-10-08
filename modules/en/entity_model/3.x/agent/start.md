<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Model (entity_model) — agent index

Developer infrastructure that lets you register Drupal **entity type and bundle classes** through a
`@Model` **annotation** or `#[Model]` **PHP attribute** placed in a module's `Entity` namespace,
instead of hand-writing `hook_entity_type_alter()` / `hook_entity_bundle_info_alter()`. Version-dir
**3.x** (installed release **3.4.0**). Core `^10.2 || ^11`, **PHP 8.1**. License GPL-2.0-or-later.
**No module dependencies.** No admin UI, **no routes, no permissions, no forms.**

## What it provides (from source)

- A **`Model` plugin type**: manager `plugin.manager.entity_model.model` (`src/ModelPluginManager.php`),
  discovered in the `Entity` subdirectory, keyed `entity_type` or `entity_type.bundle`. Annotation
  `src/Annotation/Model.php`, attribute `src/Attribute/Model.php`. → [plugins/model.md](plugins/model.md)
- Two **hook implementations** in `entity_model.module` that swap classes:
  `entity_model_entity_type_alter()` (no bundle) and `entity_model_entity_bundle_info_alter()`
  (with bundle); plus `entity_model_field_info_alter()`. Alter hook
  `hook_entity_model_model_info_alter()` (`entity_model.api.php`). → [plugins/model.md](plugins/model.md)
- A **Drush command** `entity_model:list` (aliases `model-list`, `eml`;
  `src/Commands/EntityModelCommands.php`) reporting mapped/unmapped bundles.
  → [plugins/model.md](plugins/model.md)
- Config object **`entity_model.settings`** (schema `config/schema/entity_model.schema.yml`,
  defaults `config/install/`) with `override_account_proxy` and `resolve_form_state_argument_type`,
  wired by `src/EntityModelServiceProvider.php`, the `ModelValueResolver` argument resolver, and the
  `AccountProxy` override. → [config/settings.md](config/settings.md)
- **Helper traits** `FieldHelpers` and `EntityTranslatorTrait` (`src/Entity/Traits/`), plus
  translatable field item list classes for `entity_reference`, `entity_reference_revisions`,
  `taxonomy_enum` (`src/Field/`). → [api/field-helpers.md](api/field-helpers.md)

## Solution docs

- [plugins/model.md](plugins/model.md) — the `@Model` plugin type, annotation/attribute, plugin
  manager, class-swap hooks, alter hook, and the `entity_model:list` Drush command.
- [config/settings.md](config/settings.md) — `entity_model.settings`, the service provider,
  `ModelValueResolver` (controller/FormState argument injection), and the `AccountProxy` override.
- [api/field-helpers.md](api/field-helpers.md) — `FieldHelpers`, `EntityTranslatorTrait`, and the
  translatable field item list classes.
