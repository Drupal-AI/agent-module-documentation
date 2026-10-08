<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GovUK Notify Views Backend (govuk_notify_views_backend) — agent index

Submodule of **govuk_notify**. Registers a Views base table **"GovUK Notification Message Log"**
whose rows are fetched live from the Government Notify API (via the parent module's service), plus
three exposed filters. Package `Custom`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The base table, query plugin, fields and filters, how to build a View** →
  [views/backend.md](views/backend.md)

## Dependencies

- Drupal modules: `views`, `govuk_notify` (declared in `govuk_notify_views_backend.info.yml`).
- Reuses parent service `govuk_notify.notify_service` and its `listNotifications()`.

## What it provides (from source)

- `hook_views_data()` in `govuk_notify_views_backend.views.inc` — base table
  `govuk_notify_views_backend` with `query_id: govuk_notify_views_backend`; standard fields
  `id, type, created_at, updated_at, sent_at, status, created_by, body, subject`; filterable
  `id, type, status`.
- **Views query plugin** `GovUKNotifyMessages` (`@ViewsQuery id = "govuk_notify_views_backend"`,
  `src/Plugin/views/query/GovUKNotifyMessages.php`) — `execute()` builds a filter array from the
  View's WHERE conditions (mapping `type` → `template_type`) and calls
  `notify_service->listNotifications($filters)`, turning each notification into a `ResultRow`.
- **Views filter plugins**: `govuk_notify_filter_id` (`Id`, textfield), `govuk_notify_filter_type`
  (`Type`, select email/sms/letter), `govuk_notify_filter_status` (`Status`, select
  sending/delivered/failed/permanent-failure/temporary-failure/technical-failure).
- **Service** `govuk_notify_views_backend.logger_channel` (channel `govuk_notify_views_backend`).
- `hook_help()` for `help.page.govuk_notify_views_backend`.

No entities, routes, permissions, config, or Drush. Read-only over the Notify API.
