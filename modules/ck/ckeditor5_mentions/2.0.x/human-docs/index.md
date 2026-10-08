# CKEditor5 Mentions — manual setup guide

**CKEditor5 Mentions** (`ckeditor5_mentions`) brings `@`/`#`-style mention
autocomplete to CKEditor 5. When an editor types a configured marker — typically
`@` to mention people or `#` to tag topics — a panel pops up with autocomplete
suggestions, and choosing one inserts a mention into the rich-text content. It's
the same "smart mentions" experience familiar from chat and social apps, brought
into Drupal's editor.

Unlike the small single-button CKEditor plugins, this module has a real
configuration layer: you define one or more **Mention Feeds**. Each feed sets the
trigger marker and the source of suggestions — a static list, or an entity type
(users, taxonomy terms, and so on). Feeds are managed at their own admin
collection, and the module provides its own permissions. Once a feed exists, you
enable it per text format in the CKEditor 5 settings.

A caveat worth keeping in mind: **think about what a feed exposes.** If a feed
suggests usernames, the autocomplete will reveal those names to anyone who can use
that editor. That's usually fine for trusted internal editors, but scope your
feeds appropriately if the editor is available to a wider audience.

It runs on Drupal 9.4, 10, and 11 and requires PHP 8.1 or higher. Note the module
is under active development and is not covered by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create Mention Feeds and enable them
   per text format.

## Where it lives in the admin menu

Mention Feeds are managed at **Configuration → Content authoring → Mention Feeds**
(`/admin/config/content/mention-feed`). The per-format toggle for enabling feeds
lives in each text format's CKEditor 5 settings at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). See the [Configuration](configuration/index.md)
guide for the full walk-through.
