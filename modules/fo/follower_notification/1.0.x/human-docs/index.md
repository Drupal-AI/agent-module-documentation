# Follower Notification Module — manual setup guide

**Follower Notification** (project `follower_notification`, machine name
`follower_notifications`) builds a lightweight social-notification system for
community sites where members follow one another. When a member publishes content —
or when someone comments on a member's content — the module sends the relevant
people a **bell notification and/or an email**.

It builds on the [Flag](https://www.drupal.org/project/flag) and **Flag Follower**
modules: "followers" are simply the users who have flagged an author with the
follow flag. When a member publishes a node of a configured type, each of their
followers gets a notification. When someone comments on a member's content, the
content's author is notified. Notifications appear behind a bell icon, with a popup
listing them; clicking a notification takes the user to the content, and a
notification is marked read once the target content is viewed.

For each situation you can choose whether notifications are delivered as a **bell
notification, an email, or both**. The module keeps its own notification records in
a dedicated database table.

> **Note on the machine name.** The project directory is `follower_notification`
> (singular), but the module's machine name — the name you enable and see in
> hooks — is `follower_notifications` (plural). Use the plural form with Drush.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Flag and Flag Follower.
2. [Configuration](configuration/index.md) — choose which content types trigger
   notifications and how comment notifications are delivered.

## Where it lives in the admin menu

The settings form is at **Configuration → (Follower Notifications) → Admin
settings** (`/admin/config/follower_notifications/adminsettings`), gated by the
*Access administration pages* permission. Following itself is set up through the
Flag / Flag Follower modules.

## How to use it

1. Set up Flag Follower so members can follow one another.
2. In this module's settings, pick which content types should trigger follower
   notifications and how comment notifications are delivered.
3. Place or theme the notification bell (rendered via the module's theme hook) so
   users can see their notification count and popup.
4. When a followed member publishes content, or a member's content receives a
   comment, the appropriate users get bell and/or email notifications.
