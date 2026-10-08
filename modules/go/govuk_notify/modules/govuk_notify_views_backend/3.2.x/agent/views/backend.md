<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views backend over the Notify message log

## Enable

```bash
drush en govuk_notify_views_backend -y
```

Requires `views` and a configured `govuk_notify` (the API key / service must be set up so
`listNotifications()` can return data).

## Base table (`hook_views_data`)

`govuk_notify_views_backend.views.inc` declares one base table:

- group **"GovUK Notification Message Log"**, base title same, `query_id: govuk_notify_views_backend`.
- Fields (all `field id: standard`): `id`, `type`, `created_at`, `updated_at`, `sent_at`,
  `status`, `created_by`, `body`, `subject`.
- Filterable fields wired to custom filter plugins: `id` → `govuk_notify_filter_id`,
  `type` → `govuk_notify_filter_type`, `status` → `govuk_notify_filter_status`.

Create a new View, choose **"GovUK Notification Message Log"** as the base, add the fields you want
as columns and the id/type/status filters (exposed if you want an end-user filter form).

## Query plugin `GovUKNotifyMessages`

`src/Plugin/views/query/GovUKNotifyMessages.php`, `@ViewsQuery id = "govuk_notify_views_backend"`.
Injects `govuk_notify.notify_service` and `govuk_notify_views_backend.logger_channel`.

- `addWhere($group, $field, $value, $operator)` collects conditions into `$this->where` (all under
  an AND group). `ensureTable()` returns `''` and `addField()` returns the field name unchanged —
  there is no SQL; these satisfy the Views query interface only.
- `execute(ViewExecutable $view)`:
  1. `$view->initPager();`
  2. Flattens `$this->where` into a `$filters` map: strips a leading `.` from each field name and
     maps field `type` → Notify param `template_type`; takes `current($condition['value'])` as the value.
  3. Calls `$this->notifyClient->listNotifications($filters)` (the parent service, which forwards to
     the alphagov client).
  4. For each `$response['notifications']` entry, copies every key/value into a `$row`, sets
     `$row['index']`, and appends `new ResultRow($row)` to `$view->result`.
  5. Catches `NotifyException` and logs a notice (`"Exception occurred."`).
- `@todo paging` — no pagination is implemented; results are whatever a single `listNotifications`
  call returns for the filters.

## Filter plugins

All extend `FilterPluginBase` and only override `valueForm()`:

- `Id` (`govuk_notify_filter_id`) — textfield. In Notify terms an id is a "reference".
- `Type` (`govuk_notify_filter_type`) — select: `email`, `sms`, `letter` (plus "-- select one --").
  In the query, `type` is translated to the Notify `template_type` filter param.
- `Status` (`govuk_notify_filter_status`) — select: `sending`, `delivered`, `failed`,
  `permanent-failure`, `temporary-failure`, `technical-failure`.

## Notes

- Rows come from the remote API on every (uncached) execute; there is no local storage.
- The values shown depend entirely on what the configured Notify service/account returns; an empty
  or misconfigured parent module yields an empty View (and a logged notice on API exceptions).
