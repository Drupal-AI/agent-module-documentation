<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `notification_settings` field

Field type that makes an entity bundle subscribable and lets editors trigger a notification when they
save. Add it (Field UI) to any bundle whose entities visitors should be able to subscribe to.

- FieldType: `src/Plugin/Field/FieldType/NotificationSettingsItem.php` (`id = notification_settings`,
  cardinality 1, default widget `notification_settings`, default formatter `notification_settings_default`).
- Widget: `src/Plugin/Field/FieldWidget/NotificationSettingsWidget.php`.
- Formatter: `src/Plugin/Field/FieldFormatter/NotificationSettingsDefaultFormatter.php`
  (theme hook `de_notifications_settings`, template `templates/de-notifications-settings.html.twig`).

## Properties / columns
- `subscription_enabled` (boolean, tiny int) — whether visitors may subscribe to this entity.
  `subscribe()` refuses (403) unless the target entity's `notification_settings` field has this set.
- `send_notification` (boolean, tiny int) — editor's per-save toggle to send an update notification.
- `changes` (string/text big) — human description of the change, delivered in the notification.

`isEmpty()` treats the item as empty when `subscription_enabled != 1` and `changes === NULL`.

## Field settings (labels shown in the front-end / form)
`defaultFieldSettings()` / `fieldSettingsForm()`: `subscription_enabled_label`,
`send_notification_label`, `changes_label`, `changes_description` — all translatable, configurable per
field instance (schema `field.field_settings.notification_settings`).

## How it drives notifications
- Adding/removing the field on a bundle updates state `target_entity_bundles` via
  `de_notifications_entity_bundle_field_info_alter()`, which in turn defines the allowed targets of the
  subscription's Dynamic Entity Reference.
- On save, `de_notifications_entity_update()` fires: for entities of a `published`-keyed type whose
  field has `subscription_enabled == 1` and `send_notification == 1`, and (for published entities) a
  non-empty `changes` with actual translation changes, it loads confirmed subscriptions matching the
  entity + langcode and enqueues a `notify_subscribers` queue item (`update`, carrying `changes` and
  the entity title). Unpublished entities enqueue an `archived` item instead. Draft/non-default
  revisions are skipped.
