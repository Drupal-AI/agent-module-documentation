<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture & API

## Two entity types

- **`expirable_content_type`** (config, `Entity/ExpirableContentType`) — the per-bundle policy. See
  `../config/settings.md`.
- **`expirable_content`** (content, `Entity/ExpirableContent`) — an internal (`internal = TRUE`), revisionable,
  translatable tracking record. Tables: `expirable_content` / `expirable_content_revision` /
  `expirable_content_field_data` / `expirable_content_field_revision`. `bundle_entity_type = expirable_content_type`.
  Base fields: `expiration` (timestamp), `warning` (timestamp), `content_entity_type_id`, `content_entity_id`,
  `content_entity_revision_id`. It has **no routes, no display, no forms of its own** and is not meant to be used
  directly — the computed `expiration_date`/`warning_date` fields on the source entity are the public surface.

## The information service (`expirable_content.information`)

`ExpirableContentInformation` (arg: `@entity_type.manager`), implementing `ExpirableContentInformationInterface`:

- `isExpirableEntity(EntityInterface $entity): bool` — TRUE if an enabled `expirable_content_type` matches the
  entity's type **and** bundle.
- `isExpirableEntityType(EntityTypeInterface $type): bool` — TRUE if any enabled type targets that entity type.

Both query `expirable_content_type` storage with `loadByProperties([... 'status' => TRUE])`.

## Entity-sync hooks (`EntityOperations`)

`expirable_content.module` forwards core entity hooks to `EntityOperations` (resolved via `class_resolver`):

- `hook_entity_insert` / `hook_entity_update` → `updateOrCreateFromEntity()`:
  when `isExpirableEntity()` is TRUE, load-or-create the matching `expirable_content` record; if the source
  entity's revision id changed, create a new tracking revision (`createRevision()`, default-revision aware); then
  set `expiration`/`warning` from the source entity's computed `expiration_date`/`warning_date` and `save()`.
- `hook_entity_delete` → `ExpirableContent::loadFromEntity($entity)?->delete()`.
- `hook_entity_revision_delete` → delete the whole tracking record if it is the default revision, otherwise
  `deleteRevision()` for that revision id.

`ExpirableContent::loadFromEntity()` finds the tracking record for a source entity by matching
`content_entity_type_id` + `content_entity_id` + `content_entity_revision_id` (all-revisions query). This is an
internal, id-matched lookup of the record tied to that exact source entity/revision.

## Field definitions

`EntityTypeInfo` (arg: `@expirable_content.information`) provides the computed `expiration_date`/`warning_date`
base fields via `hook_entity_base_field_info()` — see `../fields/computed-dates.md`.

## What it deliberately does NOT do

No `hook_cron`, no scheduled action, no publish/unpublish, no content deletion. Reacting to a passed expiration or
warning date is left to the site (Views, Rules, ECA, Message, etc.).
