# Revision Manager — manual setup guide

**Revision Manager** (`revision_manager`) keeps your database from filling up
with old content revisions. Every time an editor saves a node, media item,
taxonomy term, custom block, and so on, Drupal keeps the previous version as a
revision. That history is useful, but on a busy site it grows without limit.
Revision Manager lets you set retention rules — *keep at least the newest N
revisions* and/or *delete revisions older than N months* — and it prunes the
rest automatically.

It works across **every** revisionable content entity type on your site, not
just nodes: media, taxonomy terms, block content, menu links, groups, and more.
You choose which types to manage and set default rules per type on one admin
screen, and you can override those defaults for an individual bundle (for
example, keep more history on Articles than on Basic pages) right on that
bundle's edit form.

The retention logic itself is built from small pluggable rules. Two ship with
the module: **Amount** (keep the newest N revisions) and **Age** (delete
revisions older than N months). When you enable both, Revision Manager is
deliberately *conservative* — it only deletes a revision that **both** rules
agree is prunable, and it always keeps the current revision and any pending
(forward) revisions. Multilingual content is handled per translation.

Cleanup runs through Drupal's queue system: entities are queued for pruning
automatically when they're saved (unless you turn that off), or on demand from
the settings form or the `drush rm:queue` command, and the actual deletion
happens when the queue is processed (typically by cron). Access to the settings
is gated by the **Administer Revision Manager** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable entity types, set the
   Amount/Age rules, override per bundle, and run cleanup.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Revision Manager** (`/admin/config/content/revision-manager`). Per-bundle
overrides appear on each bundle's own edit form (for example **Structure →
Content types → Article → Edit**) once the entity type is managed.
