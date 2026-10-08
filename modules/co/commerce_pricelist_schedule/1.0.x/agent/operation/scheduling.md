<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduling an import (form, storage, cancel)

## Enable

```bash
composer require drupal/commerce_pricelist_schedule
drush en commerce_pricelist_schedule -y
```

Requires `commerce_pricelist` (`^2`). No settings form and nothing to configure — scheduling is
done per price list.

## The schedule form — `Form\ScheduleImportForm`

Extends `commerce_pricelist`'s `PriceListItemImportForm`, so it reuses the standard price-list
import UI (CSV upload, column **mapping**, import **options**, and the *delete existing* fieldset)
and adds one field:

- `scheduled_time` — a required `datetime` element ("Scheduled Start Time").

`buildForm()` overrides `$form['csv']['#upload_location']` to
`private://pricelists/` when `PrivateStream::basePath()` is set, otherwise `temporary://pricelists/`.
`validateForm()` first calls `file_system->prepareDirectory(...)` on that location
(`CREATE_DIRECTORY | MODIFY_PERMISSIONS`) then runs the parent validation.

`submitForm()`:

1. Loads the uploaded file (`$form_state->get('csv_file')`), marks it **permanent**, saves it.
2. Copies `$form_state->getValues()` into `import_settings` after `unset()`-ing `csv`, `actions`,
   `form_build_id`, `form_token`, `form_id`, `op` — i.e. it persists the **mapping / options /
   delete_fieldset** values as JSON.
3. Creates a `pricelist_scheduled_import` entity (`commerce_pricelist` = the route price list id,
   `import_file`, `import_settings` = `json_encode(...)`, `scheduled_time` formatted
   `Y-m-d\TH:i:s`, `status` = `pending`).
4. Records **file usage** (`file.usage` → `commerce_pricelist_schedule` /
   `pricelist_scheduled_import` / entity id) so the CSV is not garbage-collected.
5. Adds a success message and redirects to the list route.

Reached via the **"Schedule Import"** action link on the list page; route
`commerce_pricelist_schedule.schedule_import` at
`/price-list/{commerce_pricelist}/scheduled-imports/add`.

## The list — `Controller\ScheduledImportListController::list`

Route `…scheduled_import_list` at `/price-list/{commerce_pricelist}/scheduled-imports` (also the
**"Scheduled Imports"** tab on the price-list edit form). Queries
`pricelist_scheduled_import` entities for that price list (`accessCheck(TRUE)`, sorted by
`scheduled_time` DESC) and renders a table: ID, Status, Scheduled Time (`date.formatter` 'short'),
a **Download CSV** link (`file_url_generator->generateAbsoluteString`), a Yes/No for *Delete
existing?* (read from the stored `import_settings`), and an Operations column. A **Cancel** link
is shown only while status is `pending`. Footer note states old completed/failed/cancelled imports
are auto-removed after a month.

## Cancelling — `Form\ScheduledImportCancelConfirmForm`

A `ConfirmFormBase` at `…/{pricelist_scheduled_import}/cancel`. On confirm it only acts when the
import is still `pending`: sets status to `cancelled` and saves; otherwise shows an error ("Only
pending imports can be cancelled"). Then redirects to the list. Both route entities
(`commerce_pricelist`, `pricelist_scheduled_import`) are resolved as route parameters.

All three routes require the **`administer commerce_pricelist`** permission.
