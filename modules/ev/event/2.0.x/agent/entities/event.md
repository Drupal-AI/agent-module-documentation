<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event entities & fields

## `event` content entity

Class `Drupal\event\Entity\Event` (`src/Entity/Event.php`), interface `EventInterface`
(extends `EntityPublishedInterface`, `ContentEntityInterface`, `RevisionLogInterface`,
`EntityChangedInterface`, `EntityOwnerInterface`). Extends `RevisionableContentEntityBase`.

Annotation highlights:
- `base_table: event`, `data_table: event_field_data`, `revision_table: event_revision`,
  `revision_data_table: event_field_revision`.
- `translatable: TRUE`, revisionable, publishable.
- `admin_permission: "administer event entities"`.
- `bundle_entity_type: event_type`; `field_ui_base_route: entity.event_type.edit_form`
  (Field UI is per bundle).
- entity_keys: id=`id`, revision=`vid`, bundle=`type`, label=`name`, uuid, uid=`user_id`,
  langcode, status, and a custom `machine_name` key.
- Handlers: `storage=EventStorage`, `view_builder=EntityViewBuilder`,
  `list_builder=EventListBuilder`, `views_data=EventViewsData`,
  `translation=EventTranslationHandler`, `access=EventAccessControlHandler`,
  `route_provider.html=EventHtmlRouteProvider`.

Lifecycle:
- `preCreate()` defaults `user_id` to the current user.
- `preSave()` defaults any translation with no owner to the anonymous user (uid 0), and defaults
  the revision author to the event owner when unset.

API methods: `getName()/setName()`, `getMachineName()/setMachineName()`,
`getCreatedTime()/setCreatedTime()`, owner getters/setters, `isPublished()/setPublished()`.
Static `loadByMachineName($machine_name)` queries by the `machine_name` field (note: it uses the
deprecated `entity.manager` service).

### Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|-------|------|-------|
| `user_id` | entity_reference → user | "Authored by", revisionable, translatable; autocomplete widget |
| `name` | string | "Event Name", `max_length: 50`, revisionable, the entity label |
| `machine_name` | string | `max_length: 32`, `UniqueField` constraint, regex `^[a-z0-9_]+$`; `machine_name` widget sourced from `name` (needs the core machine-name-widget patch) |
| `status` | boolean | publishing status, default TRUE, revisionable |
| `event_date` | daterange | `DATETIME_TYPE_DATETIME`, `timezone_storage: TRUE`; `daterange_default` widget |
| `created` | created | |
| `changed` | changed | |
| `revision_translation_affected` | boolean | read-only, revisionable, translatable |

### `description` field (not a base field)

`config/install/field.storage.event.description.yml` installs a `text_with_summary` field storage
for the `event` entity. It is **not** attached automatically to the storage; it is attached to a
bundle by `event_add_description_field()` (in `event.module`), called from `EventTypeForm::save()`
when a new event type is created. That helper creates the `FieldConfig`, sets the
`text_textarea_with_summary` form widget, and configures `default`/`teaser` view displays.

## `event_type` config bundle

Class `Drupal\event\Entity\EventType` (`ConfigEntityBundleBase`), interface `EventTypeInterface`.
- `config_prefix: type` → config objects named `event.type.<id>`.
- `admin_permission: "administer site configuration"`.
- `config_export`: `id`, `label`, `timezone`.
- Provides `useTimezones()` returning the stored `timezone` flag. Note: `EventTypeForm` currently
  ships the timezone checkbox commented out (a `TODO`), yet `save()` still writes
  `$form_state->getValue('timezone')` (undefined → null) to the entity.
- Config schema: `event.schema.yml` defines `event.type.*` with `id`, `label`, `uuid`,
  `description`.

## Access control

`Drupal\event\EventAccessControlHandler` (`src/EventAccessControlHandler.php`):
- `view`: published → requires `view published event entities`; unpublished → requires
  `view unpublished event entities`.
- `update` → `edit event entities`; `delete` → `delete event entities`.
- create → `add event entities`.
- The `administer event entities` admin permission grants all operations via the base handler.

All per-entity CRUD (`/event/{event}`, `/event/{event}/edit`, `/event/{event}/delete`) is routed
through this handler by entity access, so operations on a given event id are permission-gated in
the normal Drupal way (no id-based bypass in the handler).
