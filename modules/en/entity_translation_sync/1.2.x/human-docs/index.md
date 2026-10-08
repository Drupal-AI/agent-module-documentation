# Entity Translation Sync — manual setup guide

**Entity Translation Sync** (`entity_translation_sync`) copies selected field
values across all of an entity's translations, so fields that should never differ
by language — a price, a date, an image, an entity reference — stay identical
without an editor updating each translation by hand. The typical case: a node has
five translations and its featured media needs to change; instead of opening five
translation forms, you set the value once and let the module propagate it.

The module gives you a dedicated page on each supported entity where you choose
which fields to push from the current language into which other languages. It works
alongside Drupal's core content translation rather than against it: marking a field
*untranslatable* in core makes it genuinely shared at the schema level (and undoing
that later is a data migration), whereas this module keeps fields translatable and
simply syncs their values on save — so a single language can still legitimately
deviate when it must, and sharing becomes an editorial policy rather than a schema
decision.

It needs configuration before use: you enable which entity types, bundles, and
fields are supported on its settings page, clear caches, and then assign
permissions. It depends on core's **Content Translation** module.

Two things to keep in mind. **Paragraph fields — and any field type based on entity
reference revisions — are not supported.** And syncing happens **on save**: values
that already differ before a field is added to the sync set are not reconciled
retroactively, so you may need a bulk re‑save to backfill existing content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Content Translation.
2. [Configuration](configuration/index.md) — enable the supported entities and
   fields, clear caches, and assign permissions.

## Where it lives in the admin menu

Its settings form is at **Configuration → Regional and language → Entity
translation sync** (`/admin/config/regional/entity-translation-sync`). Once
configured, a **"Entity translation sync"** tab appears on supported translatable
entities, where editors pick which fields to propagate to which languages.
