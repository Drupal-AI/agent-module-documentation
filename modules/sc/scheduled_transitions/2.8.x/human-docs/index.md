<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduled Transitions — manual setup guide

**Scheduled Transitions** (`scheduled_transitions`) lets editors schedule a piece
of content to change its moderation state — publish, unpublish, archive, and so on
— at a future date and time. Instead of someone logging in at 9am to click
"publish", they set it up in advance and Drupal makes the change automatically on
cron. Scheduling is per entity and per language, so a translation can transition
independently of its source.

It builds on core **Content Moderation** and the **Dynamic Entity Reference**
module. Once you enable it for a moderated content type, each such entity gains a
**Scheduled transitions** tab where an editor picks a revision, a target
moderation state, and a date/time. That choice is stored and, when the time
arrives, cron queues it and a worker creates a new default revision in the target
state with a templated log message.

You control which content types are eligible, whether cron processes transitions,
the revision-log message templates (with tokens), whether editors can override
those messages, how access is mirrored to the entity's edit permission, and
whether processed transitions are retained for auditing. There is a site-wide
listing of all pending and processed transitions, a Drush command to force
processing on demand, and an event for developers to override which revision is
transitioned.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — enable content types, the settings
   form field by field, and the permissions.

## Where it lives in the admin menu

- The settings form is at **Configuration → Workflow → Scheduled transitions
  settings** (`/admin/config/workflow/scheduled-transitions`).
- A site-wide listing of transitions is at **Content → Scheduled transitions**
  (`/admin/content/scheduled-transitions`).
- Each eligible entity gets its own **Scheduled transitions** tab.

## How to use it

1. Make sure the content type uses a Content Moderation workflow.
2. Enable that type in the Scheduled Transitions settings and grant the relevant
   permissions (see [Configuration](configuration/index.md)).
3. On a piece of content, open its **Scheduled transitions** tab, pick a revision,
   a target state, and a date/time, and save.
4. Leave cron running — the transition fires automatically when it comes due (or
   run `drush scheduled-transitions:queue-jobs` to process due ones immediately).
