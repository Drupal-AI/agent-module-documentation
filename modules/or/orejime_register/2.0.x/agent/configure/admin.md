<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin UI: view register & purge / retention

There is **no settings form** — the `configure` link in `orejime_register.info.yml` points at the
list route. All admin routes are served by `RegisterController` and gated by the
**`administer orejime entities`** permission, which is defined by the parent **orejime** module (not
by this one).

| route | path | controller method | purpose |
|-------|------|--------------------|---------|
| `orejime_register.list` | `/admin/reports/orejime-register/list` | `list()` | paged table of entries (20/page) |
| `orejime_register.purge` | `/admin/reports/orejime-register/purge` | `purge()` → `PurgeForm` | confirm-delete ALL entries |
| `orejime_register.purge_by_date` | `/admin/reports/orejime-register/purge-by-date` | `purgeByDate()` → `PurgeByDateForm` | delete entries in a date range |

The three sit under **Reports** (`orejime_register.links.menu.yml` parents `list` on
`system.admin_reports`) and appear as local tabs on the list page
(`orejime_register.links.task.yml`).

## The listing

`list()` calls `Database::list()` and renders a `#type => table`. The header derives from the row
keys: `id` and `created_at` become "Id"/"Date"; every other key is a per-service column
`{name}_{id}`, re-labelled `"{name} (id: {id})"`. Cells are the stored tinyint values (1 accepted,
0 declined). Empty state simply shows `0 elements`.

## Purge

- **Purge all** — `PurgeForm` (a `ConfirmFormBase`, form id `orejime_registry__purge`). Submit calls
  `Database::purge()`, which drops and recreates the table, logs to the `content` logger, and
  redirects to the list.
- **Purge by date** — `PurgeByDateForm extends PurgeForm` (form id `orejime_registry__purge_by_date`).
  Adds required `start_date`/`end_date` `#type => date` fields (both **inclusive**) and calls
  `Database::purgeByDate()`.

## Do it from code / drush

```php
// Delete everything:
\Drupal::service('orejime_register.database')->purge();

// Delete a range (inclusive of both ends):
\Drupal::service('orejime_register.database')
  ->purgeByDate(date_create('2025-01-01'), date_create('2025-06-30'));
```

```bash
ddev drush php:eval "\Drupal::service('orejime_register.database')->purgeByDate(date_create('2025-01-01'), date_create('2025-12-31'));"
```

The consent register holds personal data; a site should set and apply a retention period — these
purge tools are how you enforce it, but the module ships no automatic/cron expiry, so the policy is
manual (or scripted via the service above).
