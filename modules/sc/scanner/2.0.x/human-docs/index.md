# Search and Replace Scanner — manual setup guide

**Search and Replace Scanner** (`scanner`) is an administrator-driven find-and-
replace tool for the text of your content. It lets you search a term across chosen
entity fields — node bodies, Paragraphs components, Commerce products and
variations, and any entity type a Scanner plugin supports — preview every match,
then replace them all in one batch. If a replacement turns out too broad, you can
undo the last one.

Setup is a two-part job. First, on the settings page, an administrator picks which
entity type/bundle **fields** may be scanned (only text, string, and link fields
are eligible) and sets the default matching options. Then, on the tool page,
editors enter a search term and a replacement, tune the match (case sensitivity,
whole-word, regular expression, a "preceded by"/"followed by" context,
published-only, language), run a **Search** that lists and highlights every hit,
and **confirm** to replace across all matches at once. Each replace writes a new
revision (on revisionable entities) with a log message, so changes are traceable
and reversible from the **Undo** tab.

Access is gated by three permissions — search only, search and replace, and
administer settings — so you can, for example, give an auditor a safe read-only
role to see where a term appears without letting them change anything. Under the
hood the engine is a plugin system: each supported entity type is a Scanner
plugin, and developers can add support for new entity types or swap in a custom
handler.

> **Pre-stable release.** The Drupal 11 branch is `2.0.x`, and the only tagged
> release is **2.0.0-beta3** (beta). Treat it as pre-stable if you depend on it in
> production, and always preview before committing a replace.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose scannable fields, set default
   match options, and grant the permissions.

## Where it lives in the admin menu

Two separate places:

- The **tool** — where you actually run a search and replace — is at **Content →
  Search and Replace Scanner** (`/admin/content/scanner`), with an **Undo** tab at
  `/admin/content/scanner/undo`.
- The **settings** — where you choose scannable fields and defaults — are at
  **Configuration → Content authoring → Search and Replace Scanner**
  (`/admin/config/content/scanner`).

## How to use it

1. On the settings page, tick the content types and fields you want to be
   scannable, and set your default match options.
2. Grant the appropriate permission to the roles that should search and/or
   replace.
3. Go to the tool page, enter your search term and replacement, and run **Search**
   to preview the matches.
4. **Confirm** to replace across all matches. If needed, roll it back from the
   **Undo** tab.
