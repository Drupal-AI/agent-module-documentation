<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Pricelist Schedule lets an administrator schedule a Commerce Pricelist CSV import to run automatically at a chosen date and time.

---

Commerce Pricelist Schedule **adds scheduled CSV imports to Commerce Pricelist**. Instead of running a
price-list import by hand, an administrator uploads the same import CSV, sets the column mapping and
options exactly as in a normal Commerce Pricelist import, and picks a **start time**. The module stores
the upload and settings as a `pricelist_scheduled_import` entity; Drupal **cron** then picks up any due
import and processes it through a queue worker, creating or updating price-list items (optionally
deleting existing ones first). It depends on the Commerce Pricelist module.

Use it to make price changes go live at a set moment or to automate recurring price-list updates. Every
screen lives on the price list's own pages and is gated by the existing **`administer commerce_pricelist`**
permission — the module adds no configuration form and no permissions of its own. Uploaded CSVs are stored
in a private (or temporary) directory and are only downloadable by administrators. Completed, failed, and
cancelled imports older than one month are cleaned up automatically on cron.

---

- Schedule a Commerce Pricelist CSV import to run at a specific date and time.
- Upload the import CSV and set column mapping and options as in a normal price-list import.
- Coordinate a price change to go live at a planned moment.
- Automate recurring price-list refreshes without a person running each import.
- Optionally delete existing price-list items before importing the new ones.
- Run scheduled imports automatically on cron once the start time passes.
- View all scheduled imports for a price list on its "Scheduled Imports" tab.
- See each import's status: pending, in progress, completed, failed, or cancelled.
- Download the CSV attached to a scheduled import (administrators only).
- Cancel a scheduled import while it is still pending.
- Let large imports process across several cron runs via a self-requeuing queue worker.
- Keep uploaded CSVs in a private/temporary directory rather than the public files dir.
- Restrict all scheduling and cancellation to holders of `administer commerce_pricelist`.
- Rely on server-side resolution of which price list an import applies to (route entity).
- Auto-remove completed, failed, and cancelled imports older than one month.
- Track created/changed timestamps and per-import settings for each scheduled import.
- React to import progress with the `hook_commerce_pricelist_schedule_finished` hook.
- Stage a price update ahead of time and cancel it if plans change.
- Import price lists for Drupal Commerce on a schedule.
