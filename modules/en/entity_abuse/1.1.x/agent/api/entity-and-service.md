<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity, storage, service & Views field

## `entity_abuse_report` content entity

`src/Entity/EntityAbuseReport.php` — `@ContentEntityType(id = "entity_abuse_report")`.
- Base table `entity_abuse_report`; `EntityChangedTrait` + `EntityOwnerTrait` (owner key `uid`).
- Handlers: `SqlContentEntityStorage`; custom `storage_schema` = `EntityAbuseReportStorageSchema`;
  `EntityViewBuilder`; `EntityListBuilder`; access = `EntityAbuseReportAccessControlHandler`;
  `EntityViewsData`; forms `default` = `EntityAbuseReportForm`, `delete` = `EntityAbuseReportDeleteForm`.
- `field_ui_base_route = entity_abuse.settings` → Field UI (Manage fields / form display / display) hangs
  off the settings page. URI callback `entity_abuse_report_uri()` (`entity_abuse.module`).
- Base fields (`baseFieldDefinitions`): `id`, `uuid`, `langcode`, `uid` ("Reported by"),
  `created` ("Reported on"), `changed` ("Changed on"), `entity_id` (integer, unsigned — the reported
  entity id), `entity_type` (string, max 64 — the reported entity type id).
- Configurable field (config/install): `entity_abuse_report` = a `text_with_summary`/formatted-long
  "Message" field (`field.storage.*` + `field.field.*`), shown as a textarea by the default form display.

`EntityAbuseReportStorageSchema::getEntitySchema()` adds an `entity_id__entity_type` index on the base
table (speeds "already reported this entity?" lookups).

`EntityAbuseReportInterface` (`src/EntityAbuseReportInterface.php`) is the marker interface (extends
`ContentEntityInterface` + `EntityChangedInterface` + `EntityOwnerInterface`).

## Service `entity_abuse.service` — `EntityAbuseService`

`src/EntityAbuseService.php` (interface `EntityAbuseServiceInterface`). Args (`entity_abuse.services.yml`):
`config.factory`, `entity_type.bundle.info`, `current_user`, `entity_type.manager`, `database`.
Key methods:
- `getEnabledEntityTypes()` — maps each entity type id in `enabled` config to its bundle keys.
- `isReportLinkDialog()` / `getReportLinkBehavior()` / `getNoAccessBehavior()` / `getUserCancelMethod()`.
- Label + message accessors (`getAddReportLinkLabel()`, `getReportAddedMessage()`, `getNoAccessMessage()`,
  `getEditReportLinkLabel()`, `getReportEditedMessage()`, `getCancelReportLinkLabel()`,
  `getReportCanceledMessage()`, `getCancelReportNotification()`).
- `getExistingReport($entity_id, $entity_type)` — `loadByProperties` on entity_id + entity_type + current
  uid; returns the user's existing report or NULL.
- `userDelete(UserInterface $user)` — on account cancel, per `user_cancel_method`: `reassign` sets those
  reports' `uid` to 0 (anonymous), or `delete` removes them (parameterized DB update/delete on `uid`).
  Called from `entity_abuse_user_cancel()` (`hook_user_cancel`).

The lazy-builder service `entity_abuse.report_link_lazy_builder` is covered in
[../flows/submission.md](../flows/submission.md).

## Views field plugin `entity_abuse_report_entity`

`src/Plugin/views/field/EntityAbuseReportEntity.php` (`@ViewsField("entity_abuse_report_entity")`),
registered by `entity_abuse_views_data_alter()` in `entity_abuse.views.inc` as the "Related entity" field.
`query()` is a no-op; `render()` loads the reported entity from `_entity`'s `entity_type`/`entity_id` and
returns a `#type: link` to it (`$entity->label()` + `$entity->toUrl()`), or "Undefined entity." when it
cannot be loaded. Used by the bundled `entity_abuse_reports` View (see
[../config/permissions-and-review.md](../config/permissions-and-review.md)).
