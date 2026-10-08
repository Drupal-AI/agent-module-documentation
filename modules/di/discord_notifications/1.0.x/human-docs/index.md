# Discord Notifications — manual setup guide

**Discord Notifications** (`discord_notifications`) watches your Drupal site for
notable events and posts about them to a Discord channel in real time, using a
Discord **incoming webhook**. Out of the box it can announce content changes (new,
updated, and deleted content), user activity (registrations, logins, blocked
users), system events (available core/module updates, completed cron runs), and
security events (failed logins, password‑reset requests).

The problem it solves is situational awareness: instead of an administrator
repeatedly checking the site, the team's Discord server becomes a live feed of
what is happening. Each notification type can be turned on or off individually,
notifications are colour‑coded by type as Discord embeds, and you can optionally
have them ping the channel with **@here** or **@everyone**.

The module needs configuration before it does anything — at minimum you must paste
in a Discord webhook URL and choose which notification types to enable. It depends
on Drupal core's **Node** and **User** modules (both standard on most sites).
Traffic only ever flows *out* to Discord; the module exposes no inbound endpoint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and create the Discord webhook.
2. [Configuration](configuration/index.md) — set the webhook URL, choose
   notification types, and enable optional mentions.

## Where it lives in the admin menu

After enabling, configure the module at **Administration → Configuration → System
→ Discord Notifications** (`/admin/config/system/discord-notifications`). It is
gated by the **Administer site configuration** permission.
