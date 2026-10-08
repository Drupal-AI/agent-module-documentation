<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings, routes, permission

Install/enable: `drush en simple_content_notifications`. No dependencies to add. Two editable
config objects are created from `config/install/`; there are **no `config/schema/` files**, so the
settings are simple config with no typed schema.

## Routes & permission (`simple_content_notifications.routing.yml`)

| Route | Path | Access | Handler |
|---|---|---|---|
| `simple_content_notifications.settings` | `/admin/config/content/simple_content_notifications/settings` | `administer content notifications` | `ContentNotificationSettingsForm` |
| `simple_content_notifications.needing_review_settings` | `/admin/config/content/simple_content_notifications/needing_review_settings` | `administer content notifications` | `ContentReviewNotificationSettingsForm` |
| `simple_content_notifications.needing_review` | `/admin/content/needing_review` | `administer content` | `NeedingReview::reportPage` |

Permission `administer content notifications` (`*.permissions.yml`, `restrict access: true`) gates
both settings forms. The report page uses the core `administer content` permission. Menu/local-task
links live in `*.links.menu.yml` (Config → Content, and Content → "Content Needing Review") and
`*.links.task.yml` (two tabs on the settings page: "Content Updates" / "Content Review").

## Config object `simple_content_notifications.settings` (CRUD notifications)

Written by `ContentNotificationSettingsForm::submitForm()`. Keys:

- `simple_content_notifications_active` (bool) — master on/off for change notifications.
- `simple_content_notifications_addresses` (string, required) — comma-separated recipient emails.
- `simple_content_notifications_types` (array) — content-type machine names to notify on
  (`node_type_get_names()` checkboxes).
- `simple_content_notifications_live_domain` (string, required) — production domain; a
  notification sends only when `$base_url` contains this string.
- `simple_content_notifications_in_dev` (bool) — allow sending when NOT on the live domain.
- `simple_content_notifications_logging` (bool) — write notice/warning logs to channel
  `simple_content_notifications`.

Install defaults: `active: false`, `live_domain: drupal.org`, `in_dev: 0`, `logging: true`.

## Config object `simple_content_notifications.review_settings` (review digest)

Written by `ContentReviewNotificationSettingsForm::submitForm()`. Keys:

- `review_notifications_active` (bool) — master on/off for the cron digest.
- `review_notifications_addresses` (string, required) — comma-separated recipient emails.
- `review_notifications_field` (string, required) — **machine name of the node date field**
  holding the "last reviewed" date. Any content type with this field is in scope.
- `review_notifications_due` (string, required) — relative-date cutoff, e.g. `-6 months`; nodes
  whose field value is older than `now + due` are overdue.
- `review_notifications_delay` (string, required) — minimum gap between digests, e.g. `+7 days`.
- `review_notifications_subject` (string, required) — digest email subject.
- `review_notifications_published` (bool) — restrict query to published nodes.
- `review_notifications_live_domain` / `review_notifications_in_dev` (as above, for the digest).
- `review_notifications_logging` (bool).

Install defaults: `active: false`, `due: -6 months`, `delay: +7 days`, `published: true`,
`in_dev: 0`, `live_domain: drupal.org`, `subject: 'Website Content Needing Review'`,
`logging: true`.

## Next-send date is State, not config

The "Next notification send date" form element (`review_notifications_next_send`) is stored via the
**State API** key `simple_content_notifications.review_notifications_next_send`, NOT in config.
Update hook `simple_content_notifications_update_9002` migrated it out of config; hook 9001 set both
`*_logging` keys to TRUE for existing sites. Because it lives in State it is per-environment and not
deployed — reset it after a DB copy if the date is stale. If unset, cron/the form default it to
+1 day.
