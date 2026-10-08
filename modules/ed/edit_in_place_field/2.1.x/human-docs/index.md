# Edit in place field — manual setup guide

**Edit in place field** (`edit_in_place_field`) lets a field be edited directly on
the rendered page — in a View, a teaser, or full content — so an editor can fix a
value and save it without opening the full node form. Drupal core had this as
**Quick Edit** and removed it in Drupal 10; this module fills that gap for the
small correction: a typo in a heading, a wrong date, a phone number that changed.

It works by providing **field formatters**. On an entity's *Manage display*, you
switch a supported field to the **"Edit in place"** formatter, and from then on
that field renders as an inline‑editable control on the page. Supported cases
include long/basic text, simple text (like a title), and entity‑reference
selection (nodes, taxonomy terms, including references filtered by a parent
field). It plays nicely with the Claro and Gin admin themes, and you can add
richer select widgets by combining it with
[Chosen](https://www.drupal.org/project/chosen) or
[Select2](https://www.drupal.org/project/select2). One known limitation: it is not
currently compatible with the Views "Node operations bulk form" field.

Editing is gated by a permission — **"Allow to use edit in place field to save
entities"** (`edit in place field editing permission`) — which you grant to the
roles that should be able to save inline. Users without it see every field in its
normal, read‑only display; the inline controls appear only for roles that have the
permission. Treat it as the switch that turns on inline saving for a role, and
grant it to the editorial roles that already maintain this content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** — you configure it per field on *Manage
display*, and you grant the editing permission on the Permissions page. Both are
described below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage display** (or the
   *Manage display* of any fieldable entity, or a View's field settings).
2. For a supported field (long/basic text, simple text, or an entity reference),
   change its format to **Edit in place**, and configure the formatter options.
3. Go to **People → Permissions** and grant **"Allow to use edit in place field to
   save entities"** to the roles that should be able to edit inline.
4. View the content or the View as one of those roles — the field is now editable
   directly on the page, and saving writes it without opening the node form.

> **Tip:** Switch only the fields that genuinely benefit from a quick inline
> correction to the *Edit in place* formatter, and grant the editing permission to
> the editorial roles that already look after this content.
