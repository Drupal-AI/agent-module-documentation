<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base entity classes, traits & building a custom entity

All classes are `abstract` — you subclass them in your own module. Namespace root
`Drupal\entity_generic\` maps to `src/`.

## The three base classes (`src/Entity/`)

- **`Basic`** (`Basic.php`) extends core `ContentEntityBase` implements `BasicInterface`. Uses
  `EntityCreatedTrait`, core `EntityChangedTrait`, `EntityArchivedTrait`, `EntityDeletedTrait`,
  `EntityApprovedTrait`. Its `baseFieldDefinitions()` conditionally adds fields **only when the entity
  type declares the matching key**:
  - `created` key → `created` field (timestamp, revisionable if the type is).
  - `changed` key → `changed` field.
  - `archived` key → boolean `archived` + `{archived}_time` timestamp.
  - `flag_deleted` key → boolean `{flag_deleted}` + `{flag_deleted}_time`.
  - `approved` key → boolean `approved` + `{approved}_time`.
  Overrides `access()` only to default `$operation` to `'view'`.
- **`Simple`** (`Simple.php`) extends `Basic`. Uses `EntityOwnerTrait`, `EntityLabelTrait`,
  core `EntityPublishedTrait`, `RevisionLogEntityTrait`. Adds, when the key exists: revision metadata
  + `revision` id (if revisionable), `status` boolean (default TRUE), `label` string (required,
  max 255, when label key ≠ id key), `uid` owner entity_reference to `user` (default =
  `Simple::getCurrentUserId()`).
- **`Generic`** (`Generic.php`) extends `Simple`, uses `EntityTypedTrait`, implements
  `GenericInterface` (= `SimpleInterface` + `EntityTypedInterface`). Use it for a **bundleable** entity
  type; use `Simple` for a single-bundle type; `Basic` for a minimal one.

Interfaces mirror the classes: `BasicInterface`, `SimpleInterface`, `GenericInterface` in
`src/Entity/`.

## Lifecycle traits & interfaces (`src/Generic/`)

Each concern is an `Entity<X>Trait` + `Entity<X>Interface` pair (in `src/Generic/`):
`Approved`, `Archived`, `Created`, `Deleted`, `Status`, `Label`, `Typed`, `Description`, `Hidden`,
`Locked`. Pattern (see `EntityApprovedTrait`): getters read the value via
`$this->getEntityKey('<key>')` / `->get($key)`, and setters write both the flag and its `_time`
companion, e.g. `setApproved($bool)` sets `approved` to 1/0 and `approvedTime` to
`\Drupal::time()->getRequestTime()` (or 0). `GenericInterface` exposes constants such as
`ENTITY_GENERIC_APPROVED` used by the action plugins.

> Note: the interfaces are declared in namespace `Drupal\entity_generic\Generic`. A few consumers
> (e.g. `GenericPermissionProvider`) reference them under `Drupal\entity_generic\Entity`, which does
> not match the on-disk namespace — so those `entityClassImplements()` checks may not fire on this
> branch. Prefer wiring lifecycle permissions explicitly if you need them.

## How to build a custom entity type on top

In your module's content-entity annotation/attribute:

1. Extend `Generic` (or `Simple`/`Basic`).
2. Point handlers at the shipped classes: `storage` = `GenericStorage`,
   `storage_schema` = `GenericStorageSchema`, `list_builder` = `GenericListBuilder`,
   `view_builder` = `GenericViewBuilder`, `views_data` = `GenericViewsData`,
   `access` = `GenericAccessControlHandler`, `permission_provider` = `GenericPermissionProvider`,
   `route_provider['html']` = `GenericRouteProvider`, and form handlers to the `Generic*Form` classes
   (`default`/`add`/`edit` = `GenericForm`, `modal` = `GenericModalForm`,
   `delete` = `GenericDeleteForm`, etc.).
3. Declare the entity keys you want (`id`, `label`, `uuid`, `status`, `created`, `changed`, `uid`,
   and any of `archived`, `flag_deleted`, `approved`, `type`) — base fields appear only for declared
   keys.
4. Add the **marker** so the module's hooks act on your type. In the entity definition set
   `additional['entity_generic']` (a truthy array; may hold `names`, `callbacks`, etc.). See
   [../handlers.md](../handlers.md) for what `hook_entity_type_build()` and `GenericRouteProvider`
   read from `entity_generic['callbacks']` (the modal add/edit/delete/toggle controller callbacks) and
   the `add-modal-form` / `edit-modal-form` / `delete-modal-form` / `toggle-status-modal-form` /
   `merge-multiple-form` link templates.
5. For a bundleable type, define a config bundle entity extending `GenericType`
   (see [../handlers.md](../handlers.md)) with its own list builder / forms.

`entity_generic.module` helpers you can call: `entity_generic_types()` (all marked types, cached),
`entity_generic_is_generic($entity)`, `entity_generic_is_page($entity)`.
