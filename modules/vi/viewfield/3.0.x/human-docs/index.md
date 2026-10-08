# Viewfield — manual setup guide

**Viewfield** (`viewfield`) provides a **field type that embeds a View** on a
content type (or any other fieldable entity). Instead of placing a view in a
region through Block layout, you add a Viewfield to a bundle and each piece of
content references a specific View, a specific display, and optional contextual
filter arguments — and that view renders inline wherever the entity is displayed.

Technically the field is an entity reference to a View. Each value stores the
target **view**, the **display** to run, an **arguments** string (comma/slash
separated contextual filters, which understand Drupal **tokens** so you can pass
the current node's ID into a view's contextual filter), and an optional **items to
display** override. Editors set these with the default *Viewfield* widget, which
Ajax‑loads the chosen view's displays into a second select and offers an advanced
area for arguments. Field settings let a site builder restrict which views and
which display types authors may choose, or force a fixed default view on every
entity in the bundle.

Three formatters render the value: **Viewfield** (runs the view and themes it),
**Rendered entities** (renders the view's result rows as entities in a chosen view
mode), and **Title and display name** (a debug summary). Viewfield depends on core
**Views** and **Field**, and has **no module‑level settings page** — everything is
configured per field on *Manage fields* and *Manage display*. This is a **beta**
release.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no admin settings page — everything is configured per field, as
described in *How to use it* below.

## Where it lives in the admin menu

Viewfield adds **no admin menu item and no settings form**. It shows up as a field
type you can add to any bundle: at *Structure → (your content type) → Manage
fields → Add field*, choose **Viewfield**. You then configure it on that bundle's
**Manage fields** and **Manage display** screens.

## How to use it

1. Go to your content type's **Manage fields** and **Add field → Viewfield**.
   Choose the cardinality (how many distinct view displays an entity may store).
2. In the **field settings**, optionally restrict the choices:
   - **Allowed views** — limit which views authors may pick (empty = all).
   - **Allowed display types** — limit which display types, like block or page
     (empty = all).
   - **Always use default value** — hide the field on entity forms and always
     render a configured default view for every entity in the bundle.
3. When editing content, the **Viewfield** widget lets the author pick a **view**,
   then its **display**, and under *Advanced options* enter **arguments**
   (separate multiple contextual filters with `/`; use tokens like the host node's
   ID) and an optional **items to display** override (which disables the pager).
4. On **Manage display**, choose a formatter:
   - **Viewfield** — runs and themes the view; choose how the view title shows
     (Above / Inline / Hidden / Visually Hidden) and whether to build output even
     when the view returns no results.
   - **Rendered entities** — renders the view's result rows as full entities in a
     chosen view mode (single‑value fields only).
   - **Title and display name** — prints the view, display, and arguments as a
     debug summary.

Common uses include a "more articles in this section" block embedded on a node, a
featured‑content region on a landing page, or passing a taxonomy term's ID into a
view's contextual filter with a token.
