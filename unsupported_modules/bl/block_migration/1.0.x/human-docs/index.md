# Block Migration — manual setup guide

**Block Migration** (`block_migration`) exports and imports **custom block
content** so you can move blocks between environments — for example from a staging
site to production — instead of re-creating them by hand. It handles any block
bundle and field type, detects fields automatically, and carries translations
along with the block.

It builds on the **Single Content Sync** framework, treating your custom blocks as
portable content that can be exported to a file and imported elsewhere. This makes
it a useful tool for content staging and site migrations where custom blocks need
to travel with the rest of your content. It depends on core's Block content module
and on Single Content Sync, and supports Drupal 10 and 11.

Because importing brings in content from an external file, only import from
**sources you trust** — treat an import file the same way you would any content you
did not author yourself. The module provides its own permission so this capability
can be delegated deliberately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Block Migration extends the export/import capabilities that Single Content Sync
adds to Drupal. Custom blocks are managed under **Content → Blocks**
(`/admin/content/block`); the export and import actions this module supports
appear through the Single Content Sync workflow.

## How to use it

1. Enable the module and its dependency, Single Content Sync (see
   [Installation](installation/index.md)).
2. Grant the permission this module provides to the roles that should export or
   import blocks.
3. Export a custom block to a content file, then import that file on the target
   site to recreate the block — including its translations — without rebuilding it
   manually.
4. Only import files from trusted sources.
