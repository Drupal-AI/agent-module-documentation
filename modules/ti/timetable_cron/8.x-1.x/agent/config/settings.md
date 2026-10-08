<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entity, schedule form, routes & permission

## Install / enable
`drush en timetable_cron -y`. No dependencies (`core_version_requirement: ^9 || ^10 || ^11`).
On enable nothing is scheduled yet — run cron once (`drush cron`) so the module auto-creates a
`timetable_cron` entity for each discovered `hook_cron`. Manage at
`/admin/config/system/timetable_cron` (menu: Configuration → TimetableCron;
`configure` route `entity.timetable_cron.collection`).

## Config entity — `src/Entity/TimetableCronEntity.php`
`@ConfigEntityType(id = "timetable_cron")`, `config_prefix = "timetable_cron"`, so each job is
stored as config `timetable_cron.timetable_cron.<id>`. `admin_permission =
"administer site configuration"`. Handlers: list_builder `TimetableCronListBuilder`; forms
add/edit `TimetableCronForm`, delete `TimetableCronDeleteForm`, force `TimetableCronForceForm`.
`config_export` / exported keys:

| key | type | meaning |
|-----|------|---------|
| id | string | the cron **function** name (usually `<module>_cron`); machine-name field |
| status | boolean | on/off — off skips the job entirely |
| minute | string | `*`, `0`, `0..55` (step 5), or `*/10` `*/20` `*/30` |
| hour | string | `*`, `0..23`, or `*/1..*/12` |
| day | string | `*` or `1..31` (exact only) |
| month | string | `*` or `1..12` (exact only) |
| weekday | string | `*` or `1..7` (exact only) |
| desc | text | free-text description |

`lastrun` and `force` are **not** here — they live in state (see cron-override.md). The entity's
`entity_keys` declare a `function` key but the `id` is what everything uses; the id *is* the
function name.

## Config schema — `config/schema/timetablecron.schema.yml`
`timetable_cron.timetable_cron.*` → `type: config_entity`, mapping id/minute/hour/day/month/
weekday as `string`, `status` as `boolean`, `desc` as `text`. Matches the exported keys above.

## Schedule form — `src/Form/TimetableCronForm.php` (EntityForm)
Used for both add and edit (id becomes read-only once saved). Fields are all `select` dropdowns
built in `form()`: `id` (machine_name, description "Insert a function name to execute on cron
run. The function must be placed on .module file!"), `status` (Off/On), `minute`, `hour`, `day`,
`month`, `weekday` (option lists as in the table above), and a `desc` textarea. `save()` persists
the entity, adds a messenger success/error message, and redirects to
`entity.timetable_cron.collection`. `exist()` is the machine-name uniqueness callback. README notes
you can duplicate a job by giving a new id ("save as new cron") to set multiple schedules for one
function.

## List, delete & force
- `TimetableCronListBuilder` renders the collection table with extra columns **Last run**
  (formatted from `runtime['lastrun']`) and **Force onced** (Yes/No from `runtime['force']`);
  empty text "There are no cron items available."
- `timetable_cron.module` adds a **Force** entity operation (`hook_entity_operation`) and removes
  the `translate` operation (`hook_entity_operation_alter`).
- `TimetableCronDeleteForm` (`EntityConfirmFormBase`) — confirm form; on submit clears runtime via
  `TimetableCronRuntime::delete()` then deletes the entity.
- `TimetableCronForceForm` (`EntityConfirmFormBase`) — confirm form; on submit calls
  `TimetableCronRuntime::setForce($id, TRUE)` so the job runs once on the **next** cron. It does
  not execute cron itself.

## Routes & permission — `timetable_cron.routing.yml` / `timetable_cron.permissions.yml`
All five routes require `_permission: "configure timetable_cron"`:

| route | path | defaults |
|-------|------|----------|
| entity.timetable_cron.collection | `/admin/config/system/timetable_cron` | `_entity_list` |
| entity.timetable_cron.add_form | `…/add` | `_entity_form: timetable_cron.add` |
| entity.timetable_cron.edit_form | `…/{timetable_cron}` | `_entity_form: timetable_cron.edit` |
| entity.timetable_cron.delete_form | `…/{timetable_cron}/delete` | `_entity_form: …delete` |
| entity.timetable_cron.force_form | `…/{timetable_cron}/force` | `_entity_form: …force` |

The single permission `configure timetable_cron` is declared `restrict access: TRUE` (an
"administer"-grade permission). There is no anonymous or cron-key route, and no route invokes cron
on GET — scheduling only ever happens inside the overridden `cron` service on a normal cron run.
