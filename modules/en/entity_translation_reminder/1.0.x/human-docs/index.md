# Entity Translation Reminder — manual setup guide

**Entity Translation Reminder** (`entity_translation_reminder`) is a lightweight
module that nudges content editors to keep translations up to date. When someone
saves a translatable entity that already has translations, the module displays a
**reminder message** prompting them to update those translations too — so a change
made in one language doesn't quietly leave the others stale.

The reminder is opt‑in per entity type and bundle: after enabling the module you
choose exactly which translatable content types (or other bundles) should show the
message. It depends on Drupal core's **Content Translation** module and provides
its own permission; it's a purely editor‑facing convenience with no effect on
access control beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Content Translation.
2. [Configuration](configuration/index.md) — pick the entity types and bundles
   that should show the reminder.

## Where it lives in the admin menu

Its settings form is at **Configuration → Regional and language → Entity
Translation Reminder** (`/admin/config/regional/entity-translation-reminder`),
where you choose which translatable entities display the reminder message.
