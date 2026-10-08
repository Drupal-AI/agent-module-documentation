# Configuration

Emergency Notification is driven by a single settings form. Nothing shows on the
site until you fill it in and switch the notification on.

## Open the settings form

1. Log in as a user with the permission to manage emergency notifications (grant
   this only to trusted editors, since it publishes a site‑wide banner).
2. Go to **Configuration → System → Emergency Notification settings** (route
   `emergency_notification.admin_settings`).

## Configure the notification

On the form you:

- **Write the notification content** — the message visitors will see.
- **Exclude pages** — list any pages where the notification should *not* appear, so
  you can keep it off specific routes.
- **Enable it** — tick **Emergency notification enabled**.

Then click save. As soon as it's enabled and saved, the notification is visible on
your site.

## How it behaves for visitors

- The notification displays on all pages except the ones you excluded.
- A visitor can **dismiss** it.
- After dismissal it isn't gone for good — it remains accessible through a button
  fixed to the bottom of the page, so a visitor can bring it back if they need to
  re‑read it.

## Turning it off

To take the notification down, return to the settings form and untick **Emergency
notification enabled**, then save.
