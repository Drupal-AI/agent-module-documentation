# Field Report — manual setup guide

**Field Report** (`field_report`) adds a single admin report page that lists
every configured field on your site, grouped by entity type and bundle. For each
field you get its label, field type, description, a list of the *other* bundles
that reuse the same field storage ("Also Used In"), and quick Edit/Delete links
straight to the field's own forms. It is a read‑only auditing tool — it never
changes your content model, it just gives you one readable overview of it.

This is handy whenever you want to see the whole field inventory at a glance:
during a site build, a content‑model review, or a migration check. It makes it
easy to spot fields that are missing descriptions, catch inconsistent naming
across bundles, and find fields that are already shared so you can reuse an
existing field storage instead of creating a new one. A few entity types get
friendlier headings on the report (Content Types, Media, Comments, Contact Forms,
Taxonomy Terms, Blocks, Shortcut Menus).

The module depends on core's **Field UI** module and has no settings form of its
own — enable it and the report is there. Access to the page is controlled by a
single permission, **Administer field report** (`administer field_report`), and
the Edit/Delete links only appear for fields the current user is actually allowed
to change.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Field UI comes along as a dependency).

## Where it lives in the admin menu

Once enabled, the report sits under **Reports → Field report**
(`/admin/reports/fields/field-report`). It also shows up as a local task/menu
link alongside the Field storage listing.

## How to use it

1. Log in as a user who has the **Administer field report** permission (an
   administrator by default).
2. Go to **Reports → Field report**, or navigate directly to
   `/admin/reports/fields/field-report`.
3. Scroll through the tables — there is one table per bundle, with columns for
   **Field Label**, **Field Type**, **Field Description**, **Also Used In** (the
   other bundles sharing the field storage), and **Options** (Edit/Delete links).
   Within each bundle the fields are listed in the same order they appear on that
   bundle's edit form.
4. Use the **Edit** and **Delete** links to jump straight to a field's own form
   when you spot something you want to change.

There is nothing to configure — the page reflects your live field configuration
every time you open it.
