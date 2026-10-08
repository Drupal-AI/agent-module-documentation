# Replicate Actions — manual setup guide

**Replicate Actions** (`replicate_actions`) polishes the content-cloning workflow
provided by the **Replicate** and **Replicate UI** modules. Out of the box,
Replicate duplicates an entity and takes you to view the published copy.
Replicate Actions changes that so a clone starts life in a safe, editable state
and drops you straight into its edit form — fewer clicks, and no risk of a copy
going live before anyone has reviewed it.

When you duplicate content with this module enabled, the clone is created:

- **Unpublished** — or, if Content Moderation applies to that entity, set to the
  **draft** moderation state (or the workflow default, depending on one setting).
- **Owned by you** — the person doing the duplication becomes the author, and the
  created/changed timestamps are reset to now.
- **Re-added to the same Groups** as the original, if you use the Group module
  (both Group 2.x and Group 3.x are supported).
- **Opened in its edit form**, so you land ready to make changes before
  publishing.

A couple of deliberate exceptions: replicated **Paragraphs** and non-reusable
**Layout Builder inline blocks** are left published, since unpublishing them
would make no sense in context. If Content Moderation isn't installed, clones are
simply set unpublished.

The module has just one setting — a single checkbox that controls how the draft
moderation state is chosen. Everything else happens automatically.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the single moderation-state setting.

## Where it lives in the admin menu

The one setting sits at **Configuration → Content authoring → Replicate → Actions**
(`/admin/config/content/replicate/actions`), shown as a tab beside the Replicate
UI settings.
