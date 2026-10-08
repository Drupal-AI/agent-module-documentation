# Reporter — manual setup guide

**Reporter** (`reporter`) is a **report writer** for Drupal. It turns a SQL query
into a finished, re-runnable report with its own URL. You give each report a
name, a description, and the SQL that produces it, and Reporter renders the
result as a tabular report you can return to and re-run whenever you like.

It provides a configuration editor for creating and editing your reports, plus a
page that lists all your reports so you can open and view them. The module ships
with a few canned example reports to get you started — you go to the config page
to delete, add, or modify reports. It works across Drupal 10 and 11.

Because Reporter runs **SQL you write** against the site database, it can query
and expose site data — potentially including sensitive fields. Restrict who can
build and view reports to trusted administrators, and make sure a report's output
does not surface data beyond what its audience is allowed to see. The module has
no content or access role of its own beyond running the reports you define.

> **Note:** Reporter is minimally maintained and does **not** carry official
> security-advisory coverage. Because report authoring means writing raw SQL,
> treat the ability to create reports as a highly privileged, admin-only
> capability.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the report editor, field by field,
   for naming reports and writing their SQL.

## Where it lives in the admin menu

Once enabled, Reporter provides a configuration editor where you name your
reports and edit their SQL, and a separate page that lists your reports so you can
view them. See [Configuration](configuration/index.md) for how to use the editor.
