# Reference Table Formatter — manual setup guide

**Reference Table Formatter** (`reference_table_formatter`) adds a single field
formatter, **Table of Fields**, that renders the entities targeted by a reference
field as an HTML table — one referenced entity per row, one field per column —
instead of the default stacked list of rendered entities. It's a quick way to
turn a multi‑value reference field (referenced nodes, Paragraphs, terms, media,
users, and so on) into a scannable spec sheet or comparison table without writing
a custom Twig template or building a View.

You choose the columns by pointing the formatter at a **view mode** of the target
entity: only the fields enabled in that view mode become columns, and their
weights set the column order. The formatter respects access — only referenced
entities the current user may view appear as rows — and it produces correct cache
metadata so the table refreshes when a referenced entity changes.

It applies to `entity_reference` and `entity_reference_revisions` fields (the
latter is what Paragraphs uses). There are a couple of constraints to know about:
the reference field must use the **Default** selection handler, and only a
**single target bundle** is currently supported. Using a different handler or an
empty bundle list raises an error. The module needs nothing beyond Drupal core
(you use the core Field UI to select the formatter).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Reference Table Formatter adds no menu item and no global settings page. You
configure it per reference field on the entity's **Manage display** tab — for
example **Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`).

## How to use it

1. Go to the **Manage display** tab of the content type (or other bundle) that
   has your reference field.
2. In the **Format** column for that reference field, choose **Table of Fields**.
3. Click the gear icon to configure the options:

   - **View mode** — which view mode of the *target* entity supplies the columns.
     Only fields enabled in that view mode (in their weighted order) are rendered.
     Tip: create a dedicated view mode for the table and enable exactly the fields
     you want as columns. If no display config exists for the target
     bundle/view‑mode, the target's **default** display is used as a fallback.
   - **Display Entity Label** — add a first column showing each referenced
     entity's label.
   - **Hide header** — omit the table's header row for a compact, headerless
     layout.
   - **Empty cell value** — the text (for example `—` or `N/A`) placed in a cell
     when a row's entity has no value for that column's field.

4. Click **Update**, then **Save** the display.

The columns are the union of the display‑configurable fields across all the
referenced entities, so rows with different fields still line up; any missing cell
shows your empty‑cell placeholder.

### Reusing it in code (for developers)

The heavy lifting lives in a reusable service, `reference_table_formatter.renderer`
(`EntityToTableRenderer::getTable()`), which builds a `#theme => 'table'` render
array with correct cacheable‑dependency metadata. You can call it from custom code
to build an entity table anywhere.
