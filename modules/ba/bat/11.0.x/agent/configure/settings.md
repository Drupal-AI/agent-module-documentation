# Configure BAT (base module)

The base module has **no `configure` route** in its info.yml; its settings live under the
`/admin/bat/config` section it registers.

## Date settings — `/admin/bat/config/date` (`DateForm`)

Requires permission `configure bat settings`. Edits `bat.settings`:

| Key | Default | Meaning |
|---|---|---|
| `bat_date_format` | `Y-m-d H:i` | Site-wide BAT datetime format. |
| `bat_daily_date_format` | `Y-m-d` | Date-only (daily) format. |
| `bat_event_start_date` | `0` | How many days from "today" a new availability event may start (used by `bat_date_range_fields()`). |

Two **locked** `date_format` config entities ship in `config/install` and back the two formats:

- `bat.date_format.bat` — id `bat`, pattern `Y-m-d H:i`, `locked: true`.
- `bat.date_format.bat_daily` — id `bat_daily`, pattern `Y-m-d`, `locked: true`.

Set the config with Drush:

```bash
ddev drush config:set bat.settings bat_event_start_date 1 -y
```

## Type Group entity (`bat_type_group`)

A content entity for grouping unit types, with `bat_type_group_bundle` config bundles.

- Groups list: `/admin/bat/group/type-group` (perm `view any bat_type_group entity`).
- Add group: `/admin/bat/group/type-group/add[/{bundle}]` (custom `_group_type_add_access` check —
  allowed if the account may create the bundle).
- Group bundles: `/admin/bat/group/group-types` and `/add` (perm `administer bat_type_group_bundle entities`).

Bundle config schema `bat.type_group_bundle.*` has `name` and `type`.

## Config schema summary (`config/schema/bat.schema.yml`)

`bat.settings` (config_object), `bat.date_format.bat`, `bat.date_format.bat_daily` (config_object,
each `id/label/status/langcode/locked/pattern`), and `bat.type_group_bundle.*` (config_entity).

## Admin IA registered by this module

`/admin/bat` (Bat), `/admin/bat/config` (Configuration, weight 900), `/admin/bat/group` (Group,
weight 600) — all `SystemController::systemAdminMenuBlockPage` gated by `access administration pages`.
Submodules add their pages under these parents.
