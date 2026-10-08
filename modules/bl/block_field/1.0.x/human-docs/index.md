# Block Field — manual setup guide

**Block Field** (`block_field`) adds a new field type that lets editors place and
configure any Drupal block *inside* a piece of content, per node or per entity.
Normally a block is positioned once in a theme region and shown site‑wide; Block
Field turns a block into a field value instead. Add a **Block field** to a content
type, and when an author edits content they pick a block from a select list and fill
in that block's own configuration form — its label and whatever settings the block
exposes. The chosen block is then rendered inline wherever the field is displayed.

Which blocks an author may choose is controlled per field by a **selection handler**.
Two are built in: **Blocks** lets you whitelist specific block plugins, and
**Categories** allows every block within the categories you pick. Core blocks,
contrib blocks, custom (content) blocks, and Views blocks are all fair game — so you
can, for example, let editors drop a "Related articles" Views block into an article
and configure its arguments. The module has no dependencies beyond Drupal core.

There is **no site‑wide settings page**. Everything is configured per field through
the standard Field UI (Manage fields, Manage form display, Manage display) on any
fieldable entity. It's a popular, lightweight way to compose flexible pages from
reusable block components without turning on a full page builder such as Layout
Builder.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a Block field, choose which blocks
   it offers, and set its widget and formatter.

## Where it lives in the admin menu

Block Field has no menu entry of its own. You work with it wherever you manage
fields: **Structure → Content types → *[your type]* → Manage fields → Add field**,
where **Block field** appears under the *Reference* category. From there you set
which blocks are allowed, then use **Manage form display** and **Manage display** to
control the widget and how the selected block renders. See
[Configuration](configuration/index.md) for the walk‑through.
