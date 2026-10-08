# Emergency Notification — manual setup guide

**Emergency Notification** (`emergency_notification`) lets administrators publish a
customizable, prominent notice that appears on every page of the site — ideal for
closures, incidents, and other urgent announcements. It shows across the whole
site (except any pages you choose to exclude) until a visitor dismisses it, and
even after it's dismissed it stays within reach through a small button fixed to the
bottom of the page.

The module works only after you configure it: you set up the notification's
content and options and tick the "enabled" switch, and it appears immediately. It
requires no modules outside Drupal core and provides its own permission for
controlling who can manage it.

Because publishing a site‑wide banner is a high‑visibility action, grant the
module's permission only to trusted editors. The alert is admin‑authored content
shown to visitors; the module adds no access‑control behaviour of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — write the notification, choose where
   it appears, and switch it on.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Emergency
Notification settings** (route `emergency_notification.admin_settings`).
