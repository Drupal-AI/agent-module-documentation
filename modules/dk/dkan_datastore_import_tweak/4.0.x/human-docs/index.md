# DKAN Datastore Import Tweak — manual setup guide

**DKAN Datastore Import Tweak** (`dkan_datastore_import_tweak`) exposes CSV parser
options that DKAN doesn't surface on its own. Out of the box DKAN's datastore
importer assumes a comma delimiter and double‑quote quoting; if your data supplier
sends semicolon‑ or whitespace‑separated files, or uses single quotes, imports can
split columns incorrectly. This module adds a small settings form where you pick
the **delimiter** and **quoting character**, and applies them at import time.

It hooks into DKAN's import pipeline: an event subscriber listens for DKAN's
"configure parser" event and injects your chosen delimiter and quote into the CSV
parser configuration. An optional submodule,
**dkan_datastore_mysql_import_tweak**, does the same for DKAN's faster MySQL
importer (`datastore_mysql_import`), so the configured delimiter also applies to
its `LOAD DATA` path.

The only route it adds is the permission‑gated settings form, and the delimiter
and quote come from fixed dropdown options rather than free text, so they can't be
used to inject anything into the import. Set it up once and every datastore import
inherits the choice.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   against DKAN's datastore, and optionally add the MySQL‑import submodule.
2. [Configuration](configuration/index.md) — the parser settings form, field by
   field.

## Where it lives in the admin menu

The settings form is at **`/admin/dkan/parser-settings`** and requires the
**Administer site configuration** permission.
