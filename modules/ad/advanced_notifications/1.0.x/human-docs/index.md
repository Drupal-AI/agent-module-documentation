# Advanced Notifications — manual setup guide

**Advanced Notifications** (`advanced_notifications`) sends **web-push browser
notifications** — the pop-up alerts that appear on a visitor's device even when
they are not currently on your site — and wraps them in campaign management and
role targeting. Visitors subscribe (their browser asks permission), and you can
then broadcast messages to those subscribers, organise sends into campaigns, and
target specific roles for engagement or re-marketing.

Under the hood it uses the web-push standard, which relies on a pair of
cryptographic **VAPID keys** to authorise your site to push to a browser. The
module stores subscriptions and exposes several permissions, including a
sensitive one that governs the push keys themselves. It depends on Drupal core's
**REST**, **Serialization**, and **User** modules, and supports Drupal 10.3, 11,
and 12.

Because push keys are effectively credentials, keep them out of version control
(store them via an environment variable) and grant the sensitive-settings and
campaign permissions only to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and satisfy its core dependencies.
2. [Configuration](configuration/index.md) — the push/VAPID settings,
   subscriptions list, campaigns, and the permissions that control them.

## Where it lives in the admin menu

Once enabled, the module adds administrative screens for its push **settings**
(where the VAPID keys and related options live), a **subscriptions** list, and
**campaign** management. Access to each is gated by a matching permission you set
under **People → Permissions** (`/admin/people/permissions`) — most importantly
`administer web push sensitive settings`, which controls the keys.
