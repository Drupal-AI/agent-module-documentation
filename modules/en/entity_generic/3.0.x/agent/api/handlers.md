<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Handlers: storage, builders, forms, routing, permissions, access, config

All in `src/` unless noted. These are the drop-in `handlers` a derived entity type points at.

## Storage & schema

- **`GenericStorage`** extends core `SqlContentEntityStorage` implements `GenericStorageInterface`.
  Adds `revisionIds()`, `userRevisionIds()`, `countDefaultLanguageRevisions()`,
  `updateType($old,$new)` (bulk-updates the `type` column when a bundle is renamed),
  `clearRevisionsLanguage()`. Queries use the entity type's own table/key names with **bound
  placeholders** for values.
- **`GenericStorageSchema`** extends `SqlContentEntityStorageSchema`. In
  `getSharedTableFieldSchema()` it makes the `archived` / `flag_deleted` (/`dummy`) flag columns
  `not null` default `0` and adds an index on each. `getEntitySchema()` is a passthrough (TODO stub).

## Listing & rendering

- **`GenericListBuilder`** extends core `EntityListBuilder`. Adds `ID`, `Created`, `Changed` columns
  (sortable) before the default columns; `buildRow()` prepends id + formatted created/changed;
  `getOperations()` appends the current destination to the edit link; empty text "There are no
  entities available."
- **`GenericTypeListBuilder`**, **`GenericConfigListBuilder`** — list builders for the config bundle /
  config entities.
- **`GenericViewBuilder`** extends core `EntityViewBuilder`. Forces `#theme = 'entity_generic'` in
  `getBuildDefaults()`; `buildComponents()` adds a "Language" item when the display shows `langcode`.
- **`GenericViewsData`** extends Views `EntityViewsData`. Adds two exposed **ID filters**
  (`{id}_autocomplete` → filter id `entity_generic_id_autocomplete`; `{id}_select` → filter id
  `entity_generic_id_select`) and, when the matching link templates exist, three Views **link fields**:
  modal edit (`entity_generic_link_edit_modal`), modal delete (`entity_generic_link_delete_modal`),
  toggle-status modal (`entity_generic_toggle_status_modal`).

## Forms (`src/Form/`)

- **`GenericForm`** extends core `ContentEntityForm`; `save()` saves the entity, shows a success
  message, redirects to the entity canonical route.
- **`GenericModalForm`** extends `GenericForm`; renders inside an AJAX dialog
  (`core/drupal.dialog.ajax`), submit uses `use-ajax` + `submitModalAjax()` which returns a
  `ReplaceCommand` on error or `CloseModalDialogCommand` on success (with empty
  `submitModalAjaxSuccess()/Fail()` extension points). It reads `referer` from request headers and
  stores the parsed path/query in build info for the post-submit flow (not used as a redirect target).
- **`GenericDeleteForm`**, **`GenericDeleteModalForm`**, **`GenericDeleteMultipleForm`** — standard,
  modal, and bulk delete confirm forms. **`GenericToggleStatusModalForm`** — status toggle in a modal.
- **`GenericTypeForm`/`GenericTypeDeleteForm`** — bundle (config) type add/edit/delete.
  **`GenericConfigForm`/`GenericConfigDeleteForm`** — config-entity add/edit/delete.

## Controllers (`src/Controller/`)

- **`GenericController`** (`ControllerBase`): `addPage()` builds an add-list of bundles the user has
  **create access** to (checks `createAccess()` per bundle, adds cacheable dependency), and redirects
  straight to the add form when exactly one bundle is available; `addGenericEntity()` builds the entity
  add form; `addGenericEntityTitle()` title callback. Resolves entity/bundle type from route
  attributes in the constructor.
- **`GenericModalController`** extends `GenericController`: `addGenericEntityModal()`,
  `editGenericEntityModal()`, `toggleStatusModal()`, `deleteGenericEntityModal()` — each builds the
  relevant entity form via `entity.form_builder` and returns an `AjaxResponse` with an
  `OpenModalDialogCommand`. Route parameters supply the `$entity` (upcast), so access is enforced by
  the route requirements below, not by the controller.

## Routing (`GenericRouteProvider`, `src/Routing/`)

Extends Entity API's `AdminHtmlRouteProvider`. On top of the inherited canonical/add/edit/delete/
collection routes it adds, **only when the matching link template + `entity_generic['callbacks']`
entry exist**:

- `entity.<type>.add_modal_form` — for bundleable types requires **`_entity_create_access`**
  (`<type>:{bundle}`); for non-bundle types requires **`_permission: 'create <type>'`**.
- `entity.<type>.edit_modal_form` — requires **`_entity_access` `<type>.update`**.
- `entity.<type>.delete_modal_form` — requires **`_entity_access` `<type>.delete`**.
- `entity.<type>.status_toggle` and `.status_toggle_modal` — require **`_entity_access` `<type>.update`**.
- `entity.<type>.merge_multiple_form` — requires `_entity_generic_merge_multiple_access` **(the access
  service and the `GenericMergeMultipleForm` handler are not present in `src/` on this branch, so this
  route is non-functional as shipped).**

Every functional route enforces core entity access; none use `_access: TRUE` or a bare permission.

## Permissions & access

- **`GenericPermissionProvider`** extends Entity API's `EntityPermissionProvider`. Reuses that
  module's granular per-bundle own/any create/update/delete permissions and adds `view any`/`view own`
  (owner types) or `view` (non-owner), plus (per lifecycle interface) `approve any|own`,
  `archive any|own`, `mark deleted any|own`.
- **`GenericAccessControlHandler`** extends Entity API's `EntityAccessControlHandler` (no overrides —
  inherits its permission-based checks). **`GenericTypeAccessControlHandler`**,
  **`GenericConfigAccessControlHandler`** cover the config bundle / config entities.

## Manager services (pattern, not registered globally)

- **`GenericManager`** (abstract, `GenericManagerInterface`): `getAll()`, `getAvailable*()`,
  `getAvailableOptions[Uuid]()` (select options), `getByField()` (entity query, bound conditions),
  `getAddLinkModal()` / `generateAddLinkModal()` (builds an AJAX "Add new entity" modal button).
- **`GenericConfigManager`** (`GenericConfigManagerInterface`): `getAll()`, `getOptions()` (natsorted
  id→label). Subclass and register per entity type; `$entityTypeId` defaults to `entity_generic`.

## Config bundle / config entities (`src/Entity/`)

- **`GenericType`** extends `ConfigEntityBundleBase` (`GenericTypeInterface`): a **bundle** config
  entity with `description`, `help`, `new_revision` (default TRUE), `weight`; `isLocked()` reads
  `\Drupal::state()`; `postSave()` calls storage `updateType()` on rename and clears field caches.
- **`GenericConfig`** extends `ConfigEntityBase` (`GenericConfigInterface`): simple `id`/`label`
  config entity; `postDelete()` resets cache.

## Hooks, theming, config schema (`entity_generic.module`)

- `hook_entity_type_build()` — for `entity_generic`-marked content types, injects
  `delete-multiple-confirm` (+ `delete-multiple-form` link) and `merge-multiple-confirm`
  (+ `merge-multiple-form` link) form handlers/links (the merge form class is absent, see above).
- `hook_entity_view_alter()` — sets `#entity_generic` and, if a
  `templates/entity-generic--<type>.html.twig` exists in the provider module, switches `#theme`.
- `hook_theme()` registers `entity_generic` + `entity_generic_add_list`;
  suggestions/registry alters add per-type/bundle/id/view-mode template variants. Templates:
  `templates/entity-generic.html.twig` (Twig-escaped `{{ content }}`/`{{ label }}`) and
  `entity-generic-add-list.html.twig`.
- `config/schema/entity_generic.schema.yml` — schema for the enable/disable **action** configuration
  only (`action.configuration.entity_generic_enable_action` / `_disable_action`). There is **no**
  `config/install` and no module settings form.
- `entity_generic.links.task.yml` — one derivative-driven local task (`LocalTaskDeriver`).
