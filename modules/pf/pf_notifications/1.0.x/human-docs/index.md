# Push framework notifications — manual setup guide

**Push framework notifications** (`pf_notifications`) delivers **browser web‑push
notifications** — the kind that pop up from the browser or device even when the
user isn't on your site. It bridges two systems: the
[Push Framework](https://www.drupal.org/project/push_framework) channel API and
**DANSE**'s content‑subscription events, sending them over the standard **WebPush
(VAPID)** protocol. It was built and tested for use with a **Progressive Web App
(PWA)**.

The flow is: a user subscribes to notifications from their DANSE notification
settings; their browser's push subscription is stored against their account; and
when a DANSE event fires (for example, a new comment on content they're watching),
Push Framework hands off to this module, which signs and sends the push message
using your site's server **VAPID key pair**. You generate that key pair on the
module's settings page, where you can also fire a **test notification** to confirm
everything is wired up.

The module is careful about access: subscription and service‑worker actions are
gated behind a REST permission and are always scoped to the **currently
logged‑in user**, so nobody can create subscriptions for someone else, and the
per‑user notifications tab only shows to that user (or an administrator). One thing
to be aware of for operations: the server‑side **VAPID private key** is stored in
a dedicated database table and is **not encrypted** — that is standard for WebPush,
but worth knowing when you think about database access and backups.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Push
   Framework / DANSE dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — generate VAPID keys, grant the
   permissions, and let users subscribe.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Push framework →
Notifications** (`/admin/config/system/push_framework/pf_notifications`), gated by
the *Administer push notifications* permission. That is where you generate or enter
the VAPID keys and send a test notification. See
[Configuration](configuration/index.md).
