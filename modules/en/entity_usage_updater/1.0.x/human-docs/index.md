# Entity Usage Updater — manual setup guide

**Entity Usage Updater** (`entity_usage_updater`) is an administrative tool for
**rewriting references between entities in bulk**. If you need to make every
reference that currently points at node 21 point at node 42 instead, or to strip
all links to an obsolete entity out of your content, this module does it in one
operation instead of hunting through pages by hand.

It builds directly on the [Entity Usage](https://www.drupal.org/project/entity_usage)
module, which keeps a record of where each entity is referenced. Entity Usage
Updater reads that record and edits the referring content to match. It handles
several kinds of reference through a pluggable system: entity reference fields,
HTML links inside formatted-text fields, core Link fields, and Linkit-generated
links — and it works across revisions, Paragraphs, and content-moderation states.

There is one important prerequisite: **only references that Entity Usage actually
tracks can be updated.** Install and configure Entity Usage first, and make sure
it is tracking the reference types you care about. Anything it does not track,
this module cannot see or rewrite.

Because these operations edit content directly (and may create new revisions),
the two working forms are gated behind the sensitive `update referenced entities`
permission — treat it as an admin-only capability, grant it only to trusted
roles, and take a backup before running a large update.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the Entity Usage prerequisite.
2. [Configuration](configuration/index.md) — the update and link-remover forms,
   the settings page, and the permission you must grant.

## Where it lives in the admin menu

- **Update entity references** — **Content → Update entity references**
  (`/admin/content/update-references`).
- **Link remover** — `/admin/config/content/link-remover`.
- **Settings** — `/admin/config/content/entity-usage-updater`.
