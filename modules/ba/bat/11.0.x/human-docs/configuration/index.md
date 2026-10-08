# Configuration

The base `bat` module has no single "settings" link in its info file. Its
configuration lives under the **`/admin/bat/config`** section it registers, and the
most important pieces are the site-wide date settings, the type-group entity, and
the permission model that the whole suite depends on.

## Date settings

Go to **`/admin/bat/config/date`** (the **Date settings** form), which requires the
**Configure bat settings** permission. These values apply across the entire BAT
suite:

- **Date format** (`bat_date_format`, default `Y-m-d H:i`) — the site-wide BAT
  datetime format used when showing dates and times.
- **Daily date format** (`bat_daily_date_format`, default `Y-m-d`) — the date-only
  format, used where only a day matters.
- **Event start date** (`bat_event_start_date`, default `0`) — how many days ahead
  of "today" a new availability event is allowed to start. Increase it to stop
  events being created for the immediate future.

Behind these two formats sit two **locked** date-format config entities (`bat` and
`bat_daily`) shipped with the module, so the formats are consistent everywhere.

You can also set any of these from the command line, for example:

```bash
ddev drush config:set bat.settings bat_event_start_date 1 -y
```

## Type groups

BAT provides a **Type Group** entity (`bat_type_group`) for grouping unit types
together. It has configurable bundles (`bat_type_group_bundle`). You will find it
under the **Group** section:

- **Groups list** — `/admin/bat/group/type-group`.
- **Add a group** — `/admin/bat/group/type-group/add` (you may add a group of a
  bundle you have permission to create).
- **Group bundles** — `/admin/bat/group/group-types` (manage the bundle types),
  which requires the **Administer bat_type_group_bundle entities** permission.

Whether you need type groups depends on your booking model; many sites leave them
unused.

## The permission model (important)

This is the framework's signature feature and worth understanding before you assign
roles. For **every** BAT content entity type (Type Group, Unit, Unit Type, Event,
Event Series, Booking), BAT generates a consistent, **bundle-granular** permission
set:

- `create <type> entities` and, per bundle, `create … of bundle <b>`.
- `view own <type> entities` and `view any <type> entity`.
- `update own …` / `update any …` and `delete own …` / `delete any …`, each also
  available per bundle.
- `bypass <type> entities access` — a catch-all that grants everything for that
  entity type.

The `any` variants and the `bypass` permissions are flagged **restricted** ("grant
with care"), because they let a user act on content they do not own. The `own`
variants are scoped to the entity's owner (matching user id). Entity listings and
Views are automatically filtered by these grants, so a user only sees what their
permissions allow. The base module itself also defines:

- **Configure bat settings** — access the date settings form (above).
- **Administer bat_type_group_bundle entities** — manage type-group bundles.
- View permissions for unpublished type groups.

Grant these permissions at **People → Permissions**
(`/admin/people/permissions`). Each functional submodule reuses the same generator
for its own entity types, so once you understand the scheme for one entity type it
applies to all of them — see each submodule's own documentation for its specific
permission names.

## For developers

BAT exposes a `hook_bat_entity_access()` hook so other modules can allow or deny
non-view operations on BAT entities, plus helper APIs (a `bat_date` route param
converter, `bat_date_range_fields()`, type-group load/save helpers, and
`bat_get_entity_display()`). These are covered in the
[`agent/`](../agent/start.md) docs.
