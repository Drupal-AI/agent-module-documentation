# Content Publishing Job — manual setup guide

**Content Publishing Job** (`content_publishing_job`) does two related things for
sites that need content to come and go on a schedule. Its main job: you define
"publishing config" jobs that **automatically unpublish** nodes of a chosen
content type once a configured date field has passed — perfect for news items,
events, or announcements that should drop off the site after their expiry date.
Its second feature is a **Related contents block** that shows other content
related to the current page by a shared taxonomy term.

The unpublishing runs on cron. Each job pairs a content type with a date field;
on every cron run the module finds published nodes of that type whose date has
passed, queues them, and unpublishes them in the background. It only ever
*unpublishes* — it never publishes anything — so it can't accidentally expose
embargoed or draft content, and there's no web-facing endpoint that triggers it;
cron is the only trigger. The module depends on core's **Block** module and
supports Drupal 9 and 10.

One caveat worth knowing on sites that use **Content Moderation**: the worker
force-unpublishes nodes directly, bypassing moderation state transitions. If your
site relies on moderation workflows, weigh whether a moderation-aware approach
suits you better before turning this on for moderated content types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This project is not covered by Drupal's security advisory policy.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create unpublish jobs, place the
   Related contents block, and make sure cron runs.

## Where it lives in the admin menu

The publishing jobs are managed at **Configuration → System → Publishing config**
(`/admin/config/system/publishing-config`), which is the `publishing_config`
entity collection. The Related contents block is placed through the block layout
manager at **Structure → Block layout**.

## How to use it

1. Enable the module and make sure cron is running (see
   [Installation](installation/index.md)).
2. Create one unpublish job per content type, choosing the date field that
   determines expiry — see [Configuration](configuration/index.md).
3. Optionally place the **Related contents** block in a region and configure it to
   relate content by a taxonomy term field.
4. Let cron do the rest: expired published nodes are unpublished automatically in
   the background.
