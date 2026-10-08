# Configuration

Notifications Widget is configured in three places: the **general settings**
form, the **logger settings** form, and the **block** you place to display the
bell. The module's own documentation stresses one thing above all — after
installing, **open the general settings and save them once**, even if you change
nothing, or the widget may not behave correctly.

## General settings

1. Log in as a user with **Administer site configuration**.
2. Go to **`/admin/config/system/notifications_widget`**.

This form controls how notifications are composed and displayed. Notification
messages support **token replacement**, so you can write a message template such
as `Lorem ipsum read data by [user:name]` and have the token filled in when the
notification is created — other useful tokens include `[node:title]` and
`[comment:entity:title]`. You can also control whether the widget shows content
based on the **admin** or the **logged‑in user**. **Save** the form once when you
are done — this is the required post‑install step.

## Logger settings

Go to **`/admin/config/people/notifications_widget/loggers`** (also under
*Administer site configuration*). This is where you choose **which events are
logged** as notifications. The path sits under *People* because deciding what
activity to surface is treated as a people‑management concern. The module can log
activity for core entities and can be extended to additional provided entities
such as profile types and paragraphs, and it integrates with Views for node,
comment, term, profile, and message.

If you are a developer, note that other modules can create notifications
programmatically through the logging service rather than relying only on the
configured loggers:

```php
$notificationService = \Drupal::service('notifications_widget.logger');
$message = [
  'id' => '1234',
  'bundle' => 'article',
  'content' => 'Lorem ipsum read data by [user:name]',
  'content_link' => 'users-list',
];
$notificationService->logNotification($message, 'create', $entity);
```

## Place and style the bell block

The bell is a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Notifications Widget** block in a region — the header is the usual
   spot.
3. Configure the block's own settings and restrict its visibility to the users
   who should see notifications.

The dropdown ships with stylesheets, but the module expects a **Bootstrap theme
or equivalent CSS** in your project for the bell and dropdown to look right —
make sure that is in place, or add matching styles in your own theme.
