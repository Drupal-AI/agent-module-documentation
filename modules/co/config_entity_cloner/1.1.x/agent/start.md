<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Entity Cloner — agent index

info.yml name: **Config Entity Cloner** (`config_entity_cloner`), package Development, core `^9 || ^10 || ^11`.
No non-core dependencies. Version 1.1.0.

Adds a **Clone** action to the operations list of every configuration entity (views, content types,
image styles, field configs, vocabularies — anything extending `ConfigEntityBase`). Choosing it opens a
clone form that duplicates the entity plus its related configuration (fields, displays, translations,
Simple Sitemap settings) under a new label and machine name. There is **no central settings form** — the
module has no config of its own and provides no config schema.

## How it hooks in

- `config_entity_cloner_entity_operation_alter()` (`config_entity_cloner.module`) adds a
  `clone_configuration` operation link to every `ConfigEntityBase` with an id, linking to route
  `config_entity_cloner.clone_form`.
- Route `config_entity_cloner.clone_form`:
  `/admin/config/system/cetc-clone/{type}/{initial_bundle}/{redirect}`, form
  `Drupal\config_entity_cloner\Form\CloneForm`, gated by permission
  **`administer config_entity_cloner configuration`** (defined in `.permissions.yml` with
  `restrict access: true` — the single dedicated gate).
- The link passes the current route name as `{redirect}`; after cloning the form redirects to the new
  entity's `edit-form` link template if it has one, else back to that route.

## Clone flow

1. `CloneForm` (`FormBase`, POST) — loads the original via `type` + `initial_bundle` route params, shows a
   label textfield and a `machine_name` element. `validateId()` rejects a machine name that already
   exists for that entity type (no overwrite of an existing config entity from the UI). Submit is CSRF
   token-protected (standard `FormBase`).
2. Service `config_entity_cloner.cloner` (`Service/ConfigEntityCloner.php`) —
   `duplicateEntity()` calls `createDuplicate()`, sets the new id/label keys, saves; then a **batch** runs
   the clone processes. `getDefaultCloneEntityId()` / `getDefaultCloneEntityLabel()` suggest an unused
   `name_2`-style default.
3. Each process copies one kind of related config for the entity's bundle.

## Plugin types (two, annotation-based)

- **ConfigEntityClonerProcess** (`@ConfigEntityClonerProcessAnnotation`, id/label/weight) — one unit of
  duplication; implements `cloneProcess(newEntity, originalEntity)`. Bundled processes:
  `fields_clone_process` (FieldConfig + base-field overrides), `form_display` / `view_display`,
  `translation_clone_process` (`language_content_settings`), `simple_site_map` (guarded by
  `\Drupal::hasService('simple_sitemap.generator')`). Errors inside a process are caught + logged, not
  fatal.
- **ConfigEntityClonerProcessor** (`@ConfigEntityClonerProcessorAnnotation`) — selects which processes run
  for a given entity type via `getProcessList()`. `default` runs all of them; a processor whose id matches
  an entity-type id overrides the list for that type.
- Scaffold new plugins with `drush generate config-entity-cloner-process` /
  `config-entity-cloner-processor` (generators in `src/Generators/`).

## Drush

`drush.services.yml` registers `ConfigEntityClonerCommands`: `config_entity_cloner:cloneConfigEntity`
(aliases `cec:cce`) — `drush cec:cce <entityTypeId> <entityId> [--new-entity-id] [--new-entity-label]`.
CLI clone via the same service (no batch UI). Note: the `--new-entity-label` value is read from the
`new-entity-id` option key in source (functional quirk).

## Files

- `src/Form/CloneForm.php` — clone form, id validation, redirect.
- `src/Service/ConfigEntityCloner.php` — load/duplicate/process, default id+label, batch builder.
- `src/Tools/Batch.php` — thin batch wrapper (operations, finish/redirect callbacks, common data).
- `src/Plugin/config_entity_cloner/…` — bundled process + the `default` processor.
- `src/PluginManager/…` — the two plugin managers, annotations, interfaces, wrappers.

Developer/site-building tool operating purely in the config layer; it creates config entities and has no
runtime access-control role. Keep the clone permission with trusted site builders and review clones, since
a duplicate may carry over references that need adjusting.
