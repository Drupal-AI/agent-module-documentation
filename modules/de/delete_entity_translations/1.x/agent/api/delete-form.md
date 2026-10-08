<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete form, route, permission & batch logic

Everything the module does lives in one form class:
`src/Form/DeleteEntityTranslationsForm.php` (`Drupal\delete_entity_translations\Form\DeleteEntityTranslationsForm`,
extends core `FormBase`, form id `delete_entity_translations_form`).

## Install / enable

- `composer require drupal/delete_entity_translations` then `drush en delete_entity_translations`.
- No dependencies beyond Drupal core (`^10.1 || ^11 || ^12`). No config to import.
- Grant the **`delete entity translations`** permission to trusted administrator roles only; then
  use it and disable the module again if it was only needed for a one-off cleanup.

## Route & permission

- Route id **`delete_entity_translations`** (`delete_entity_translations.routing.yml`):
  - path `/admin/config/regional/delete-entity-translations`
  - `defaults._form` = the form class, `_title` = "Delete entity translations"
  - `requirements._permission: 'delete entity translations'`
- Permission **`delete entity translations`** (`delete_entity_translations.permissions.yml`):
  title "Delete Entity Translations", **`restrict access: TRUE`** (Drupal flags it in the UI as
  security-sensitive). This is the only gate; there is no separate per-entity access check in the
  batch (see "Behaviour notes"), so the permission alone must be treated as a
  trusted-administrator grant.
- Menu link `delete_entity_translations` under parent `system.admin_config_regional`
  (`delete_entity_translations.links.menu.yml`) → appears at
  **Configuration → Regional and language**.
- `configure: delete_entity_translations` in the `.info.yml` wires the module's "Configure" link
  to the same route.

## The form (`buildForm`)

Two required inputs plus submit:

- `langcode` — `select`, options from `getLanguages()`:
  `languageManager->getLanguages()` mapped to `$language->getName()` (keys are langcodes). Only
  configured site languages appear.
- `entity_types` — multi-`select`, options from `getEntityTypes()`: iterates
  `entityTypeManager->getDefinitions()` and includes every definition where
  `$definition->hasKey('langcode')` (label → option), `asort()`ed. This means **any** langcode-keyed
  entity type is eligible (nodes, terms, media, block_content, and also entities such as users if
  they carry a langcode key), not just node.
- `submit` — "Delete entities / translations".

It is a standard POST `FormBase`, so Drupal's automatic form token (`form_build_id` / CSRF token)
applies; there is no state-changing GET path.

## Submit → batch (`submitForm` → `runDeleteEntityTranslations`)

- `submitForm()` reads `langcode` + `entity_types` and calls
  `runDeleteEntityTranslations(string $langcode, array $entity_types)`.
- That builds one Batch operation per selected entity type — callback `[$this, 'processItems']`
  with args `[$langcode, $entity_type]` — sets `finished` = `[$this, 'finished']`, and calls core
  `batch_set()`. The batch runs on the next page request.

## Batch worker (`processItems`)

- `const BATCH_SIZE = 50` — entities per batch pass.
- First pass per entity type (`empty($context['sandbox'])`): resolves the type's `langcode` key via
  `getDefinition()->getKey('langcode')`, stores the label, and counts matches with
  `getStorage($type)->getQuery()->accessCheck(FALSE)->condition($langcode_key, $langcode)->count()`.
  On exception it warns and finishes that operation.
- Each pass: `getQuery()->accessCheck(FALSE)->condition($langcode_key, $langcode)->range(0, 50)`
  → `loadMultiple($ids)`. For each entity implementing `TranslatableInterface`:
  - if not the default translation, switch to `getUntranslated()` (operate on the original);
  - if the entity's original language **equals** the selected langcode → `$entity->delete()`
    (removes the whole entity and all its translations);
  - else if `$entity->hasTranslation($langcode)` → `$entity->removeTranslation($langcode)` then
    `$entity->save()` (removes only that one translation).
- Progress is tracked in `$context['sandbox']` (`progress`/`max`) and reported via
  `$context['message']`; `$context['results']['processed']` accumulates the count.
- `finished(bool $success, array $results, array $operations)` shows a status message
  "Deleted @count entities or their translations".

## Behaviour notes / gotchas

- **Irreversible, bulk.** When the picked language is an entity's original language the *entire*
  entity is deleted, not just a translation — so choosing a default/original language can wipe
  content wholesale. Always back up before running against production.
- The entity queries use `accessCheck(FALSE)` and there is **no per-entity `->access('delete')`
  check** in the batch — every matching entity of the selected type is processed. Access is
  therefore controlled entirely by the single `restrict access: TRUE` permission on the route;
  grant it only to administrators you trust with site-wide content deletion.
- Selectable types are driven purely by the presence of a `langcode` key, so the list can include
  more than editorial content; review the entity type before selecting it.
- Deleting entities in bulk fires the usual entity delete/save hooks and can be slow on large
  datasets; the 50-per-pass batch keeps each request bounded.

## OOP hook

- `src/Hook/DeleteEntityTranslationsHooks::help()` (`#[Hook('help')]`, autowired service in
  `delete_entity_translations.services.yml`) returns the About text on
  `help.page.delete_entity_translations`. `delete_entity_translations.module` keeps a
  `#[LegacyHook]` `delete_entity_translations_help()` shim that delegates to the service.
