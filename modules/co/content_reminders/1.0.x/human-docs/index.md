# Content Reminders — manual setup guide

**Content Reminders** (`content_reminders`) is a reminder system for content. It
lets site administrators set up automatic reminders about specific pieces of
content — "review this page by a date", or other content-lifecycle prompts — so
that important content maintenance doesn't quietly slip. Reminders are sent by
email to a designated address, or to a set of comma-separated addresses, making it
easy to keep blog posts, news articles, and other pages fresh and up to date.

It's an editorial-workflow / administration feature: reminders and notifications
are governed by the module's own permissions, and it has no access-control role
beyond that. The module has no dependencies beyond Drupal core and supports Drupal
9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This project *is* covered by Drupal's security advisory policy. Because
> reminders are emailed to configured addresses, grant the module's permissions
> only to the administrators/editors who should manage them.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has no single settings page to walk through field by field; reminders
are configured per content with recipient email addresses, as described in "How to
use it" below. Assign its permissions on **People → Permissions**.

## Where it lives in the admin menu

Content Reminders provides its own permissions (managed on **People →
Permissions**, `/admin/people/permissions`) and lets you attach reminders to
content with one or more recipient email addresses. Grant the reminder permissions
to the roles that should manage reminders.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On **People → Permissions**, grant the Content Reminders permissions to the
   administrator/editor roles that should be allowed to create and manage
   reminders.
3. Set up a reminder for a piece of content, entering the email address — or a
   comma-separated list of addresses — that should be notified, and the date/
   schedule on which the reminder should fire.
4. When the reminder is due, the configured recipients receive an email prompting
   them to review or update that content. Make sure your site can send email
   (outgoing mail must be configured) for the notifications to arrive.
