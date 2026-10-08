# Flexible Views — manual setup guide

**Flexible Views** (`flexible_views`) improves the usability of core Views by
letting **end users** control a table view — which columns are shown, in what
order — and which exposed filters are visible. It's ideal for wide data tables and
filter‑heavy admin listings, where you want to offer a clean default but still let
power users expand the view to suit themselves.

It ships three Views plugins that you wire together in the Views UI:

- **Flexible Table** — a table style (a drop‑in replacement for core's Table)
  that adds a *"Visible by default"* checkbox per column, so you decide which
  columns show up front and which are available on demand.
- **Visible Column Selector** — an exposed filter that gives visitors a
  two‑list "available / selected columns" widget with move buttons, so they can
  show, hide, and reorder columns themselves. Their choices persist across pages
  of the same view (via the query string and session).
- **Manual selection** — an exposed‑form style that lets users pick which exposed
  filters to reveal from a select list, keeping a view with many filters tidy.

There is **no settings page, no permissions, and no Drush** — everything is
configured inside the Views UI, per view. The module depends only on core's
**Views** and runs on Drupal 10 and 11. A couple of nice touches: bulk‑operations
and operations columns are always kept visible regardless of user selection, and
if you use the `views_field_permissions` module, fields hidden by access are
excluded from the column selector automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

(There's no separate configuration page — this module has no admin settings form.
You configure it inside each View, described below.)

## Where it lives in the admin menu

There is no admin settings page. You configure everything inside the Views UI at
**Structure → Views** (`/admin/structure/views`) when editing a view.

## How to set it up

A typical setup uses all three plugins together:

1. **Choose the Flexible Table style.** Edit your view and set its **Format** to
   **Flexible Table**. It inherits all the normal core Table settings (sortable,
   alignment, separators, responsive priority, "hide empty column", etc.) and adds
   a **Visible by default** checkbox for each column — untick it for columns you
   want hidden until the user asks for them.
2. **Add the Visible Column Selector filter.** Under **Filter criteria**, add
   **Visible Column Selector** and expose it (it must be exposed — the option is
   forced on). On the front end this renders the two‑list column widget with
   move buttons. By default it's wrapped in a collapsible *details* element to save
   space. The user's chosen columns and order are what the Flexible Table then
   renders.
3. **(Optional) Switch the exposed form to Manual selection.** In the exposed‑form
   settings, choose **Manual selection** so users can add exposed filters from a
   select list rather than seeing them all at once. Pager links are rebuilt so
   they carry only the filters the user actually enabled. You can also configure
   some filters to always show.
4. Save the view.

Because everything lives inside the view's own configuration (there are no global
defaults to install), you can mix and match: one view can offer full column control
while another stays a plain table.
