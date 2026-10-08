# Drush Webmaster — manual setup guide

**Drush Webmaster** (`drush_webmaster`) provides a large suite of structured,
validated Drush commands (all prefixed `wm:*`) for managing a Drupal site from
the command line — designed especially for **AI-assisted site management**. It
lets you (or an AI coding assistant such as Claude Code, Cursor or Copilot) query,
create, edit and inspect entities, content types, fields, views, menus,
vocabularies, blocks, media, translations and moderation workflows, with output
in structured YAML that both agents and human operators can read.

The important design choice is that Drush Webmaster does **not** shell out to
execute arbitrary AI-generated code. Instead, the agent chooses and parameterises
the provided commands, and each command is backed by input validators (for
example `ContentTypeValidator` and `FieldValidator`) that check machine names and
bundle/entity references before anything is created or changed. That keeps a large
surface of routine site-building work available to an agent while guarding against
the obvious foot-guns.

That said, these commands perform **real structural and content changes** —
creating content types, adding fields, editing entities, and more — and the
project describes itself as giving agents "full creative AND destructive power"
over a site. The CLI is already a privileged context; combined with the module's
own permissions, that means you should run these commands only in appropriate
environments (local, dev, staging) and be deliberate about production. It requires
PHP 8.1 and depends on core's node, field and user modules.

Highlights of what the `wm:*` commands cover: full site-schema discovery
(`wm:schema:dump`), entity querying with field conditions and operators, a
YAML export/edit/apply workflow with `--dry-run` validation and versioned
history (with revert), bulk create/update/delete, views management, content-type
and field management, menu management, translation management, content
moderation, and full-text search.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it ships no settings form.
It is used entirely through its `wm:*` Drush commands (it does define
permissions, which you grant to roles at **People → Permissions** as with any
module).

## How to use it

Drush Webmaster adds no admin page; everything happens through Drush. A common
first step is to dump the site schema so you — or your AI assistant — understand
an unfamiliar site:

```bash
drush wm:schema:dump
```

From there, the `wm:*` commands let you query and manage entities, content types,
fields, views, menus, media, translations and moderation. A safe pattern for
changes is the export/edit/apply workflow: export an entity or view to a
versioned YAML file, modify it, then apply with `--dry-run` first to preview the
change before saving. Run `drush list wm` (or `drush help wm:schema:dump`, etc.)
to explore the full command reference for your installed version.
