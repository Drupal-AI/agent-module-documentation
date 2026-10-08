<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete Entity Translations (delete_entity_translations) — agent index

A single admin **form** that batch-deletes content entities and their translations for a chosen
**language** across selected **entity types**. No dependencies beyond core; works with any entity
type that declares a `langcode` key. Core requirement `^10.1 || ^11 || ^12`.
License GPL-2.0-or-later. Version 1.1.0 (doc dir `1.x`).

- **The form, the route/permission, the batch delete logic, and how to operate it** →
  [api/delete-form.md](api/delete-form.md)

## What it actually is

- One form: `DeleteEntityTranslationsForm` (form id **`delete_entity_translations_form`**), in
  `src/Form/DeleteEntityTranslationsForm.php`, extending core `FormBase`.
- One route: **`delete_entity_translations`** →
  `/admin/config/regional/delete-entity-translations`, `_form` = the class,
  requirement `_permission: 'delete entity translations'`.
- One permission: **`delete entity translations`** (`delete_entity_translations.permissions.yml`,
  `restrict access: TRUE`).
- One menu link under **`system.admin_config_regional`** (`*.links.menu.yml`).
- One hook: `hook_help` for `help.page.delete_entity_translations`, implemented as an OOP hook via
  `src/Hook/DeleteEntityTranslationsHooks.php` (autowired service; `*.module` keeps a
  `#[LegacyHook]` shim).
- **No** config objects/schema, **no** services beyond the hook class, **no** Drush, **no**
  plugins, **no** submodules, **no** libraries.

## Mechanism (from source)

- `buildForm()` renders two selects: `langcode` (from `getLanguages()`, the configured languages)
  and multi-select `entity_types` (from `getEntityTypes()` — every entity-type definition where
  `hasKey('langcode')`), plus a submit.
- `submitForm()` → `runDeleteEntityTranslations($langcode, $entity_types)` builds one Batch API
  operation per selected entity type (callback `processItems`) and `batch_set()`s it.
- `processItems()` (batch size **50**, `const BATCH_SIZE`): counts and pages entity ids by
  `langcode` via `getStorage()->getQuery()`, loads them, and for each `TranslatableInterface`
  entity: if the entity's **original** language equals the picked langcode it `->delete()`s the
  whole entity; else if it `hasTranslation($langcode)` it `->removeTranslation($langcode)` and
  `->save()`s.
- `finished()` prints a "Deleted @count entities or their translations" status message.

## Operate it

1. Enable the module; grant **`delete entity translations`** to trusted admins only.
2. Visit `/admin/config/regional/delete-entity-translations`, pick a language + entity type(s),
   submit, and let the batch run. Deletion is bulk and irreversible — back up first.
