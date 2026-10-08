<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core Activity (crm_core_activity) — agent index

Provides the `crm_core_activity` content entity (interactions logged against contacts) and its
config bundle `crm_core_activity_type`, driven by **activity-type plugins**. Part of the CRM Core
suite. Core `^9 || ^10 || ^11`, GPL-2.0-or-later.

Depends on: `crm_core_contact`, `entity`, `dynamic_entity_reference` (participants), core `text`,
`datetime`, `options`. Uses the contrib `plugin` module's decorator in `*.plugin_type.yml`.

## Entities

- **`crm_core_activity`** (`src/Entity/Activity.php`) — `ContentEntityBase`, `EntityOwnerTrait`.
  Base table `crm_core_activity`; keys id `activity_id`, bundle `type`, owner `uid`, label `title`.
  `permission_granularity = "bundle"`. Base fields: `type` (ref to activity type, read-only),
  `title` (required), `created`, `changed`, `activity_participants`
  (**dynamic_entity_reference**, cardinality −1, targets `crm_core_individual` &
  `crm_core_organization`, required), `activity_date` (datetime, default now), `activity_notes`
  (text_long). `label()` delegates to the type plugin. Access handler
  `ActivityAccessControlHandler`.
- **`crm_core_activity_type`** (`src/Entity/ActivityType.php`) — `@ConfigEntityType`,
  `config_prefix = "type"`, `admin_permission = "administer activity types"`. Exported:
  `name`, `type`, `description`, `activity_string`, `plugin_id` (default `generic`),
  `plugin_configuration`. Holds a `DefaultSingleLazyPluginCollection` for its plugin. `preDelete()`
  deletes all activities of the type.

## Plugin type: `activity_type_plugin`

- Manager `plugin.manager.crm_core_activity.activity_type` = `ActivityTypePluginManager`
  (namespace `Plugin/crm_core_activity/ActivityType`, interface `ActivityTypePluginInterface`,
  annotation `Annotation\ActivityTypePlugin`, alter hook `activity_type_plugin_info`).
- Base class `ActivityTypePluginBase`; shipped plugin `Generic` (id `generic`) whose `label()`
  returns the activity title.
- Config schema keys `plugin_id` + `plugin_configuration` (`crm_core_activity.configuration.<id>`).

## Routes / permissions

- `/crm-core/activity` (perm `view any crm_core_activity entity`),
  `/admin/structure/crm-core/activity-types` (perm `administer activity types`).
- Static perms: `administer activity types` (restricted), `view crm dashboard`; dynamic via
  `ActivityPermissions::permissions()` (CRM Core builder, incl. per-bundle variants checked by the
  access handler).

## Hooks

`crm_core_activity_entity_predelete()` → `crm_core_activity_pre_delete_checker()`: on deleting an
Individual/Organization, strips it from participant lists and deletes activities left with none.

## Solution docs

- **Activity entity, participants, access, cleanup** → [entities/activity.md](entities/activity.md)
- **Activity-type plugin framework** → [plugins/activity-type.md](plugins/activity-type.md)
