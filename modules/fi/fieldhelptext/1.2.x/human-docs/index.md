# Field Help Text — manual setup guide

**Field Help Text** (`fieldhelptext`) gives you one screen for editing the
**description (help) text** on your fields, instead of opening each field's settings
form one at a time. Help text is the cheapest editorial documentation a site has and
the most neglected, precisely because improving it normally means visiting a
separate settings page for every single field — dozens of page loads to fix wording
that takes seconds to write. This module collapses that into a bulk editor.

It offers two editing approaches:

- **Edit the help text for every field on a content entity.** On a bundle with many
  fields it is easy to overlook help text; this form lets you fill in guidance for
  all of them at once and keep a consistent tone and vocabulary.
- **Edit a field's label and help text everywhere the field is used.** When a field
  is reused across several content types, edits often end up applied inconsistently.
  This form changes the label and help text across all bundles at the same time —
  and if one bundle needs different wording, you can exclude that instance by
  unticking a box.

Both forms work for **all fieldable content entities**, not just node types —
taxonomy terms, blocks, users, comments, and so on. It has no dependencies.

The clever design decision is its permission. Help text lives in field
*configuration*, so editing it would normally require a permission like *administer
node fields* — which also lets someone add, change, and delete fields. Field Help
Text carves out a single narrow permission, **`use fieldhelptext`**, so a content
designer or technical writer can improve field guidance without being handed the
ability to alter your data model.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module, then grant the `use fieldhelptext` permission.

This module has **no settings form of its own** — the two editing screens *are* the
module, described in "How to use it" below.

## Where it lives in the admin menu

The landing page is at **`/admin/structure/fieldhelptext`**, with the per-bundle
editor at **`/admin/structure/fieldhelptext/by-bundle/{entity_type}/{bundle}`**.
Both are gated by the single **`use fieldhelptext`** permission.

## How to use it

1. Grant the **`use fieldhelptext`** permission to the roles that should edit
   guidance (see [Installation](installation/index.md)).
2. Visit `/admin/structure/fieldhelptext` and pick the entity type and bundle you
   want to work on, which opens the per-bundle form.
3. On the per-bundle form, edit the description text for each field in one place; on
   the "everywhere the field is used" form, change a field's label and help text
   across all bundles at once, unticking any instance that needs different treatment.
4. Save. Because these edits change field configuration, they show up in
   `drush cex` output and must be deployed like any other configuration change —
   editing directly on production creates config drift, so make the changes where
   you manage config.
