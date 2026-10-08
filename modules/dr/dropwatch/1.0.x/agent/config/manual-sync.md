<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manual-sync form

`src/Form/DropWatchManualSyncForm.php` — a plain `FormBase`, form id
**`dropwatch_manual_sync_form`**, route `dropwatch.manual_sync` at
**`/admin/config/system/dropwatch/manual-sync`** (permission `administer dropwatch`).

- `buildForm()` renders explanatory markup ("Submitting this form will run a manual sync to
  DropWatch.") and a single **Submit** button.
- `submitForm()` fetches `\Drupal::service('dropwatch.service')` and calls `sendApiRequest()`, then
  adds the messenger notice: *"Manual Sync Submitted. Check your logs for any issues."*
- It is a standard Drupal form POST, so it carries the framework CSRF form token; there is no
  state-changing GET route.

Use it to trigger an immediate sync without waiting for cron (cron otherwise syncs via
`dropwatch_cron()` on every run).
