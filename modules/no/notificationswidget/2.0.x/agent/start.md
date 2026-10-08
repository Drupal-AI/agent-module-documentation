<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notifications Widget (notificationswidget) — agent index

Bell-icon activity feed. Logs create/update/delete on configured entity bundles into three custom DB
tables and renders them as an unread-count dropdown block; a POST endpoint marks items read/deleted/
cleared per user without a page reload. Project machine name is `notificationswidget` but the module
(and `drush en`) name is **`notifications_widget`**. Depends on core `user`, `block`, `rest`,
`system (>=8.1.0)`. Core `^8.8 || ^9 || ^10 || ^11`.

`configure` route: `notifications_widget.notifications_widget_settings`
(`/admin/config/system/notifications_widget`). Defines **no permission of its own** (admin forms use
core `administer site configuration`; the REST route uses core `access content`), **no drush**, **no
plugin types**, **no submodules**. Has config schema (partial). Alpha-only branch — see Key facts.

- **Per-bundle logging on/off, message templates + link tokens, exclude/add entity types** →
  [configure/settings.md](configure/settings.md)
- **Logging API for other modules (`logNotification`) + the DB tables** → [api/service.md](api/service.md)
- **The POST endpoint that marks read / delete / clear-all** → [api/rest.md](api/rest.md)
- **The bell dropdown block + its per-instance display modes** → [blocks/notification-widget-block.md](blocks/notification-widget-block.md)
- **How entity create/update/delete trigger a notification** → [hooks/logging.md](hooks/logging.md)
- **Views integration (relationships + fields on the notifications table)** → [views/notifications.md](views/notifications.md)

Key facts:
- Config object `notifications_widget.settings`. Fixed keys: `excluded_entities` (CSV),
  `additional_entity_type` (CSV), `notfication_widget_conf` (flag, note the typo). Per-bundle dynamic
  keys: `{bundle}_enable` (CSV of `Create,Update,Delete`), `{bundle}_noti_{create|update|delete}_message`,
  `{bundle}_redirect_{create|update|delete}_link` (default `[entity:url]`).
- Service id `notifications_widget.logger`, class `NotificationsWidgetService`, interface
  `NotificationsWidgetServiceInterface`; method `logNotification(array $message, string $userAction,
  object $entity, int $recipient_uid = NULL, int $operator_uid = NULL): void`.
- Storage is three `hook_schema` tables (NOT entities): `notifications`, `notifications_actions`
  (read/delete markers, status 1=read 2=delete), `notifications_clear_all` (per-user clear watermark).
- REST resource `notifications_update_widget`, POST `/api/notification_update`, json + cookie auth,
  installed from `config/optional/rest.resource.notifications_update_widget.yml`.
- Block plugin id `notification_widget_block` (category "Notifications widget"); library
  `notifications_widget/drupal.notifications`; theme hook `notifications_widget`.
- Two admin forms: settings (`notifications_widget_settings`) and logger settings
  (`notifications_widget_admin_settings`, `/admin/config/people/notifications_widget/loggers`).
- Token replacement supports `user`, `node`, `taxonomy_term`, `comment` entities only.
- Branch `2.0.x` has **no stable release**; newest tag is `2.0.0-alpha9` (documented here). Newest
  stable overall is on the unrelated `8.x-1.x` branch.
