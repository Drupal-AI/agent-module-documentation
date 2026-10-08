# Pathauto — manual setup guide

**Pathauto** (`pathauto`) automatically generates clean, readable URL aliases —
like `/blog/my-first-post` instead of `/node/42` — for your content, users,
taxonomy terms, and other entities. Instead of typing a path by hand on every
piece of content, you define a **pattern** once (for example
`[node:content-type]/[node:title]`) and Pathauto builds the alias for you every
time an entity is saved. It relies on the **Token** module for the placeholders in
those patterns and on core's **Path** module for storing the finished aliases.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to creating your
first pattern and back-filling aliases for content you already have. If you are
looking for terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Patterns tab listing the site's URL alias patterns](images/patterns.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Search and metadata → URL
aliases** (`/admin/config/search/path`). That page is organised into tabs:

- **List** — every existing alias on the site.
- **Patterns** (`/admin/config/search/path/patterns`) — the alias patterns you define.
- **Settings** (`/admin/config/search/path/settings`) — global cleanup rules.
- **Bulk generate** (`/admin/config/search/path/update_bulk`) — create aliases for
  existing content.
- **Delete aliases** (`/admin/config/search/path/delete_bulk`) — remove aliases in bulk.

## Contents

1. [Installation](installation/index.md) — install Pathauto with Composer and
   enable it along with its dependencies.
2. [Configuration](configuration/index.md) — tune the global settings that control
   how aliases are cleaned and updated.
3. [Creating a pattern](creating-a-pattern/index.md) — define a token-based URL
   alias pattern for an entity type.
4. [Bulk generate aliases](bulk-generate/index.md) — back-fill aliases for content
   that was created before your pattern existed.
