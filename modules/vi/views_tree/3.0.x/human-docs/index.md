# Views Tree — manual setup guide

**Views Tree** (`views_tree`) adds Views display styles that render a view's rows
as a **nested hierarchy** — a tree — instead of a flat list or table. It works
with the "adjacency model": each row carries its own unique id and the id of its
parent, and Views Tree reassembles those flat rows into proper parent/child
nesting at render time. That makes it a natural fit for taxonomy vocabularies,
organization charts built from a "manager" self-reference, product categories,
threaded structures, book outlines, file/folder listings, and any content that
points at a parent of the same type.

It ships three style plugins, all chosen in the **Format** section of a view:

- **Tree (list)** — renders the hierarchy as a nested `<ul>`/`<ol>`. It can be
  made **collapsible**, so long trees can be expanded or collapsed by the visitor
  (via a small jQuery script the module attaches).
- **Tree (table)** — renders a regular table where one column is indented to show
  the hierarchy, while the other columns stay flat — good for tree "reports".
- **TreeHelper (Adjacency model)** — a special style used behind
  **entity-reference** widgets, so an autocomplete or select list can present its
  options hierarchically indented.

Every tree style needs you to tell it two things: which field holds each row's
**unique id** (the *Main field*) and which field holds the **parent's id** (the
*Parent field*). A row whose parent value is `0`, empty, or doesn't match another
row becomes a root of the tree. The table style additionally asks which column
should be indented to show the hierarchy. That's essentially all the configuration
there is.

Everything is stored inside the view's own configuration — there is **no admin
settings page, no route, no permission, and no Drush command**. The module also
ships an entity-reference selection handler so a reference field can pull its
options from a tree-styled view with indentation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the style plugin
ids, the option keys, and the tree-building service — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views Tree has **no page of its own**. You use it from the **Views UI**, under
**Structure → Views** (`/admin/structure/views`), by setting a view display's
**Format** (style) to one of the tree styles.

## How to use it

1. Create or edit a view of the content that carries the parent relationship
   (**Structure → Views**).
2. Add a **field** for each row's **unique id** (for example Term ID or Content
   ID) and a **field** for the **parent id** (for example the target id of the
   parent reference). If you only need them to build the structure, mark both
   **Exclude from display**.
3. In the **Format** section, click the current style and choose **Tree (list)**
   or **Tree (table)**.
4. Open the style **Settings** and set:
   - **Main field** — the field holding each row's unique id.
   - **Parent field** — the field holding the parent's id.
   - *(Tree table only)* **Hierarchy display column** — the column to indent to
     show the hierarchy (usually the title/label).
   - *(Tree list only)* **Collapsible view** — leave off, or set to *Expanded* or
     *Collapsed* to make the tree expand/collapse in the browser.
5. **Apply** and **Save**.

The view now renders as a nested tree. A handy trick: clone a display and switch
only its style, and you can reuse the same underlying view as both a flat listing
and a tree.
