# Views Field View — manual setup guide

**Views Field View** (`views_field_view`) adds a **"Global: View"** field handler
to Views, letting you embed one view as a field inside another and pass argument
(contextual filter) values from the parent row into the embedded child view. It is
the classic way to build master/detail and related-content listings without writing
a custom Views plugin.

You add the **Global: View** field to a "parent" view, and it renders a chosen
display of a "child" view once per parent row. The field's **Contextual filters**
setting takes a list of replacement tokens that map the parent's fields and
arguments onto the child view's contextual filters — so each parent row drives what
its embedded child shows. Tokens come in four flavors: `{{ raw_fields.FIELD }}` and
`{{ fields.FIELD }}` (the raw versus rendered value of a parent field), and
`{{ raw_arguments.ID }}` / `{{ arguments.ID }}` (the raw versus titled value of a
parent argument). Anything that matches no token is passed straight through as a
static argument.

Because parent fields render in order, only fields placed **above** the Global:
View field can be used as its tokens, and each token field should be output clean
(no label, no extra markup) — usually by marking it "Exclude from display". The
child view is loaded, access-checked, and previewed per row, and each embedded
pager gets its own id so multiple pagers on the page do not collide. Recursion is
guarded: a view that would embed itself renders "Recursion, stop!" unless you
deliberately enable the module's `evil` flag. There is no admin settings form and
no permissions — it depends only on core **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. The **Global: View** field becomes available in the
**Views** UI at **Structure → Views** (`/admin/structure/views`) when you add a
field to any view.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit the parent view and add the field **Global: View**.
3. In its settings, choose which **view** and **display** to embed (default, a page,
   a block, or an attachment).
4. Fill in **Contextual filters** with the tokens that feed the child view — for
   example `{{ raw_fields.nid }}` to pass the parent node ID, or
   `{{ arguments.ID }}` to forward a parent argument. Separate multiple values with
   commas or forward slashes; static text is passed as a fixed argument.
5. Make sure any field you reference as a token sits **above** the Global: View
   field, and mark it **Exclude from display** so its markup is clean.
6. Save. Each parent row now renders the child view filtered by that row's values.

Enable Views caching on the embedded display to offset the extra per-row queries,
and use "hide empty" to suppress the child output when it has no results.
