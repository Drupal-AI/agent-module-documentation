# Metatags Import Export CSV — manual setup guide

**Metatags Import Export CSV** (`metatag_import_export_csv`) adds two admin screens
that let you **bulk export** the meta tags of your content to a CSV file and **bulk
import** a CSV to update them again. It works across any entity that has a Metatag
field — nodes, users, taxonomy terms, and so on — and runs both operations as batch
processes, so it copes with hundreds or thousands of entities.

The typical workflow is: export a content type's meta titles and descriptions to a
spreadsheet, hand it to a marketing or SEO team to edit offline, then re‑import the
edited file to push the changes back. Each import row identifies its entity (either
by entity type + id, or by path alias) and names the Metatag field to write to;
you can target a specific translation, leave a cell empty to keep the current
value, or use the special value `_blank` to clear a tag.

It sits alongside — and requires — the **Metatag** module (plus **Token**). It has
no configuration of its own; the only thing you set up is who is allowed to export
and who is allowed to import, via its two permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the Metatag and
   Token dependencies, and enabling the module.
2. [Configuration](configuration/index.md) — the export and import forms, the two
   permissions, and the exact CSV column format.

## Where it lives in the admin menu

Both screens live under **Configuration → Search and metadata → Metatag**:

- **Export/download** — `/admin/config/search/metatag/download`
- **Import/upload** — `/admin/config/search/metatag/upload`

Each is gated by its own permission (see
[Configuration](configuration/index.md)).
