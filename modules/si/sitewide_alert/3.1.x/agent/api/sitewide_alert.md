<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sitewide Alert entity API

Alerts are instances of the **`sitewide_alert`** content entity
(`\Drupal\sitewide_alert\Entity\SitewideAlert`, interface `SitewideAlertInterface`).
It is fieldable, revisionable, translatable. Entity keys: `id` → `id`,
`label` → `name`, `published` → `status`, `uid` → `user_id`, `uuid`, `langcode`.

## Base fields

| Field | Type | Notes |
|---|---|---|
| `name` | string (max 50) | **Required.** Administrative label (the entity's label key). |
| `message` | text_long | The banner body (rich text). Translatable. |
| `status` | boolean | "Active" — the published flag; an alert only shows when active. |
| `style` | list_string | **Required.** Allowed values come from `sitewide_alert.settings:alert_styles` (e.g. `primary`). |
| `dismissible` | boolean | Visitor can dismiss (stored per-browser). |
| `dismissible_ignore_before_time` | timestamp | Ignore dismissals made before this time. |
| `scheduled_alert` | boolean | Enable the start/end schedule. |
| `scheduled_date` | daterange | `value` (start) + `end_value` (end), UTC storage. |
| `limit_to_pages` | string_long | One path per line; `*` wildcard, `/` = front page. |
| `limit_to_pages_negate` | boolean | Show on all pages EXCEPT those listed. |
| `user_id` | entity_reference (user) | Author. |
| `created` / `changed` | timestamps | |

## Create an alert

```php
$storage = \Drupal::entityTypeManager()->getStorage('sitewide_alert');
$alert = $storage->create([
  'name'    => 'Maintenance notice',   // required, admin label
  'message' => 'Scheduled maintenance tonight 22:00–23:00 UTC.',
  'style'   => 'primary',              // must be a key from alert_styles
  'status'  => TRUE,                   // active/published
  'dismissible' => TRUE,
]);
$storage->save($alert);
```

Scheduled variant (only shows between the two times):

```php
$alert = $storage->create([
  'name' => 'Launch banner', 'message' => 'We are live!', 'style' => 'primary',
  'status' => TRUE,
  'scheduled_alert' => TRUE,
  'scheduled_date' => ['value' => '2026-01-01T09:00:00', 'end_value' => '2026-01-02T09:00:00'],
]);
$storage->save($alert);
```

## Load / inspect

```php
$storage = \Drupal::entityTypeManager()->getStorage('sitewide_alert');
$all = $storage->loadMultiple();                    // every alert
$active = $storage->loadByProperties(['status' => 1]);
foreach ($active as $a) {
  printf("%s [%s] active=%d\n", $a->label(), $a->get('style')->value, $a->get('status')->value);
}
```

`loadByProperties(['name' => 'Launch banner'])` finds by admin label. The message
value is `$a->get('message')->value`; the style key is `$a->get('style')->value`.

## Service

`sitewide_alert.sitewide_alert_manager` (`SitewideAlertManager`) resolves the set
of alerts that should be visible for the current request (active + scheduled +
page/visibility rules); the `sitewide_alert_domain` submodule decorates it. The
client fetches them as JSON from `/sitewide_alert/load`
(`SitewideAlertsController::load`, permission `view published sitewide alert entities`).
