# Decoupled Entity Notifications — manual setup guide

**Decoupled Entity Notifications** (`de_notifications`, often shortened to "DEN")
lets people subscribe to changes on Drupal entities and delivers notifications
when those entities change. It's built with **decoupled/headless** front-ends in
mind: a separate front-end application can register a visitor's interest in
specific entities through the module's API and then receive notifications as
content is updated.

At its heart the module provides a subscription API plus a configurable
`notifications_settings` field that you add to the entity bundles you want to make
subscribable. That field carries a subfield controlling whether an entity can be
subscribed to at all, and a user-configurable subfield describing which changes
should trigger notifications (with a text field for a human-readable
description). Delivery is extensible: DEN ships with a **Symfony Mailer**
notification submodule (DENSM), and its modular design lets developers add other
notification-type submodules.

Because subscriptions tie **users to entities**, they involve personal data —
handle it accordingly. Notifications should only ever reveal entities and fields
the subscriber is actually allowed to see, so make sure your notification content
respects entity access, and gate subscription management behind the module's
permissions. The module has no access-control role of its own beyond those
permissions.

This module needs several setup steps to work — a secret key in `settings.php`,
an admin settings page, cron jobs, and the notifications field added to your
bundles — so plan to follow the configuration guide end to end. It depends on the
**Dynamic Entity Reference** module and supports Drupal 10 and 11. It is actively
maintained and covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Dynamic Entity Reference dependency.
2. [Configuration](configuration/index.md) — the secret key, the settings form,
   the cron jobs, and adding the notifications field to your bundles.

## Where it lives in the admin menu

The module's settings form is at **`/admin/config/system/de_notifications`**. The
subscribable behaviour itself is configured per bundle by adding the
`notifications_settings` field on each entity type's **Manage fields** screen.
