# Fast Revision Purge — manual setup guide

**Fast Revision Purge** (`fast_revision_purge`) plans and bulk-deletes old node
and paragraph revisions in resumable batches, so your revision tables stop growing
without bound. You set a retention policy — how many of the latest node revisions
to keep, whether to keep everything since a given date, whether to protect the
latest published revision, and how many paragraph revisions to keep — then preview
the result with a dry run and purge from the admin UI or with Drush.

Over time, every save of a node adds a revision, and on a busy site those tables
become the largest in the database. This module prunes them: it works in chunked,
resumable batches so long purges do not time out, it discovers your node and
paragraph revision tables (and the `node_revision__layout_builder__layout` table
when Layout Builder is used) at runtime, and it protects the current/default
revision of each node and paragraph plus, optionally, the latest published node
revision. Paragraphs still referenced by kept node revisions are traced through
entity_reference_revisions fields so their revisions are not removed.

> **Deleting revisions is destructive and irreversible.** A purged revision — and
> the historical content it held — is gone; you lose that slice of audit and
> rollback history. Always run a **dry run** first to review exact counts, take a
> database backup before a real purge, and keep this tool in the hands of trusted
> administrators only (access requires the *Administer site configuration*
> permission).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set retention policies, run a dry
   run, and purge (UI and Drush).

## Where it lives in the admin menu

Its settings and purge controls live at **Configuration → Development → Fast
Revision Purge**. See [Configuration](configuration/index.md) for the field-by-field
walkthrough and the Drush commands.
