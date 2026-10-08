<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Model lets developers register Drupal entity type and bundle classes through a `@Model` annotation or PHP attribute instead of hand-writing entity-type/bundle-info alter hooks.

---

Defining custom behaviour for a Drupal entity type or bundle normally means implementing `hook_entity_type_alter()` or `hook_entity_bundle_info_alter()` and mapping each class by hand. Entity Model replaces that boilerplate with a plugin: you place a class in your module's `Entity` namespace, extend the relevant core entity/bundle class, and tag it with `#[Model(entity_type: 'node', bundle: 'page')]` (or the equivalent `@Model` annotation). A plugin manager (`plugin.manager.entity_model.model`) discovers these classes, and the module's own hook implementations swap the entity type class (when only `entity_type` is given) or the bundle class (when both `entity_type` and `bundle` are given). On top of registration it adds developer conveniences: automatic injection of model entities into controller method arguments by type hint (and, optionally, `FormStateInterface` arguments), an optional `AccountProxy` override that makes `current_user`'s `getAccount()` return the full `User` entity, translatable entity-reference field item list classes, and the `FieldHelpers` / `EntityTranslatorTrait` traits. The `drush entity_model:list` command reports which bundles are mapped to which model classes. It is pure developer infrastructure — there is no admin UI, and the two optional features are toggled in the `entity_model.settings` config object. Requires Drupal 10.2/11 and PHP 8.1; no module dependencies.

---

- Register an entity bundle class with a `@Model` annotation or `#[Model]` attribute instead of an alter hook.
- Override an entire entity type's class by giving `@Model` only an `entity_type`.
- Override a single bundle's class by giving `@Model` both `entity_type` and `bundle`.
- Add typed getter methods (e.g. `getBody()`) to a node bundle class and have them available everywhere that entity loads.
- Place model classes under your module's `Entity` namespace so the plugin manager auto-discovers them.
- Verify class mappings with `drush entity_model:list` (aliases `model-list`, `eml`).
- Filter the mapping report to only mapped or only unmapped bundles with `--filter-mapped-status=mapped|unmapped`.
- Inject a model entity into a controller method just by type-hinting the model class in canonical entity routes.
- Enable fuzzy argument resolving on a custom route by setting the `_enable_fuzzy_argument_resolving` route option.
- Type-hint `$formState` (instead of `form_state`) in a form-handling method after enabling `resolve_form_state_argument_type`.
- Make `current_user`'s `getAccount()` return the real `User` entity by setting `override_account_proxy: true`.
- Use `FieldHelpers::getDateTime()` / `getDateTimes()` to read date, datetime, created, changed and timestamp fields as `\DateTime` objects.
- Use `FieldHelpers::setDateTime()` / `setDateTimes()` to store `\DateTime` values into date-like fields with correct timezone handling.
- Use `FieldHelpers::formatLink()` / `formatLinks()` to turn link fields into structured arrays (url, text, external, target/entity).
- Use `FieldHelpers::getMediaSource()` to fetch the source field item list of a referenced media entity.
- Translate a single entity or a list of entities to the current content language with `EntityTranslatorTrait::translateEntity()` / `translateEntities()`.
- Get translated referenced entities automatically via the translatable entity-reference field item list classes.
- Access `$field->translation` / `$field->translations` magic properties on entity-reference fields for context-translated targets.
- Support translated `entity_reference_revisions` fields when that module is installed.
- Support translated `taxonomy_enum` fields when that module is installed.
- Model the `user` entity type (no bundle) to add methods to loaded user accounts.
- Alter discovered model definitions with `hook_entity_model_model_info_alter()`.
- Migrate a legacy `wmmodel` (Wieni) integration to the Drupal.org `entity_model` namespace.
- Keep bundle-class logic in typed PHP classes rather than scattered procedural hooks.
- Reduce boilerplate when a project has many custom bundle classes.
- Build a strongly-typed domain model layer over Drupal content entities.
- Confirm a newly added model class is picked up after a cache rebuild.
