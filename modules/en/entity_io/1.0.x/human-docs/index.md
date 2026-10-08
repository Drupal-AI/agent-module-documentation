# Entity IO — manual setup guide

**Entity IO** (`entity_io`) exports and imports Drupal entities as **JSON files**,
making it easier to migrate or synchronize content between environments or sites.
When you export an entity it goes "as deep as possible" — including all fields and
related entities — and when you import, that whole graph is restored, including
referenced users, taxonomy terms, paragraphs, media and other content, so
relationships and data integrity are preserved.

You control how much is included: which fields are exported and how deeply related
entities are followed, from simple field values to deeply nested references. For
example, exporting an article with comments also captures the comments, referenced
nodes, taxonomy terms and media. Each entity type gets its own **export tab**, and
entities that support revisions can export a specific revision from the revision
overview. On import, when an entity already exists Entity IO shows a **side‑by‑side
diff** so you can review the changes before applying them, and it can create a new
revision and record a chosen user as the author of the change. Exported files can
live in **public or private** file storage, and every export is a portable JSON file
you can version, share or import elsewhere. Entity IO also offers **Drush commands**
for CLI‑based exports and imports, and a family of submodules (queue, webhooks, push,
purge) for larger and more automated workflows.

Because Entity IO can export and import content — **including potentially sensitive
user data** — treat it as a privileged tool: restrict it to trusted administrators,
handle exported JSON files carefully (they may contain personal data), and review
the import diff before applying changes to a live site. It depends on core `media`,
`user`, `node`, `taxonomy`, `block` and `comment`, and supports Drupal 10, 11 and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and note its submodules.
2. [Configuration](configuration/index.md) — export and import workflows, the
   options (revisions, author, storage), the import diff, and Drush commands.

## Where it lives in the admin menu

Entity IO adds a dedicated **export tab** to each supported entity type, plus (for
revisionable entities) an export option in the revision overview. The complete
export/import workflow, options and CLI commands are described in
[Configuration](configuration/index.md).
