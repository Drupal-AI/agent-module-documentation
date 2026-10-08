# Simple Comment Notify — manual setup guide

**Simple Comment Notify** (`scn`) tells the people who run your site whenever a
new comment is posted — by email, by Telegram message, or both. Instead of
repeatedly checking the comment moderation queue, moderators and admins get an
alert the moment a comment is created, with a link straight to it.

You decide who gets notified: the site's main admin account (user 1), the author
of the node that was commented on, everyone holding one or more chosen roles
(for example a "Moderator" role), and/or any list of plain email addresses you
type in. For chat‑style alerts, SCN can also post to one or more Telegram chats
through a bot you set up, and — where the Telegram API is blocked — route that
through a SOCKS5 proxy. Each notification can optionally include links to the
comment‑approval overview and the comment edit page to speed up moderation.

The module builds directly on Drupal core's **Comment** module and needs nothing
else. Everything is controlled from a single settings form, and access to that
form is gated by its own **Administer SCN configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form field by field:
   recipients, the custom mail list, Telegram, and the SOCKS5 proxy.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Simple Comment Notify**
(`/admin/config/system/scn`). You need the **Administer SCN configuration**
permission to open it.

## How to use it

Once enabled, SCN does nothing until you tell it who to notify. Open the settings
form, tick the recipients you want (admin, node author, roles, or a custom mail
list), optionally turn on Telegram delivery, and save. From then on every new
comment triggers a notification. See [Configuration](configuration/index.md) for
each option.
