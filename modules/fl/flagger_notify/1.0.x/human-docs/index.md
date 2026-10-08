# Flagger Notify — manual setup guide

**Flagger Notify** (`flagger_notify`) is a helper for the
[Flag](https://www.drupal.org/project/flag) system that solves a common need:
automatically emailing users when content they have bookmarked or subscribed to
(via a flag) is updated. In effect it turns any flag into a "follow this" feature
— a member flags a piece of content, and Flagger Notify tells them by email when
it changes, without them having to check back.

It's built for performance. Rather than sending mail while the editor is saving,
it uses Drupal's Queue API and processes the emails in the background on **cron**.
That means even if thousands of users flagged a piece of content, editing it won't
slow the site down. It also deduplicates intelligently: a user gets one email per
update even if they flagged the content with several flags (and you can turn that
deduplication off if you prefer). Notifications are grouped and processed by
language.

You decide which flags trigger notifications, and you customize the email subject
and body using HTML and **tokens** such as `[node:title]` or
`[user:display-name]`. Administration is gated by the **Administer flagger notify**
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (with Flag and Token), and confirm cron is running.
2. [Configuration](configuration/index.md) — the settings page: general options,
   email templates, and which flags send notifications.

## Where it lives in the admin menu

The settings page is at **Configuration → System → Flagger Notify**
(`/admin/config/system/flagger-notify`), gated by the **Administer flagger
notify** permission. Notifications are sent on cron, so a regularly running cron is
part of the setup.
