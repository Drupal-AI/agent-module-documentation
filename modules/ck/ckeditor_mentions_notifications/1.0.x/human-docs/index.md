# CKEditor Mentions Notifications — manual setup guide

**CKEditor Mentions Notifications** (`ckeditor_mentions_notifications`) closes the
loop on `@`‑mentions: when someone mentions a user in a CKEditor field (via the
CKEditor Mentions module), the mentioned user receives an email notification. It
is an add‑on to **CKEditor Mentions** and does nothing on its own without it.

There are three moving parts. A mentioned user gets an email when their name is
referenced; a site administrator configures the email that goes out — a custom
subject and body built with **tokens**, so you can personalize it with the
mentioner's name, a link to the content, and so on; and each user can turn their
own mention notifications on or off from their profile page, respecting their
preference.

A short privacy note is worth keeping in mind. Mentions and their notifications
reveal that a particular user was referenced, and they typically email that user,
so make sure notifications go only to the intended recipient and that this fits
your site's email and privacy practices. The module has no access‑control role of
its own.

It requires PHP 8, Drupal 10 or 11, and the **CKEditor Mentions** module. Note it
is **not covered by the Drupal security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside CKEditor Mentions.
2. [Configuration](configuration/index.md) — write the token‑based email subject
   and body, and understand the per‑user opt‑out.

## Where it lives in the admin menu

The module provides an admin settings form for the notification email (subject and
body with tokens). In addition, each user's own **profile edit** page gains a
checkbox to enable or disable mention notifications for themselves. The
administrator settings and the per‑user toggle are described in
[Configuration](configuration/index.md).
