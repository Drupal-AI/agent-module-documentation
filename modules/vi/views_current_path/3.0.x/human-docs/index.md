# Views Current Path — manual setup guide

**Views Current Path** (`views_current_path`) adds a single field to Views — **Global: Current
path** — that prints the path, URL, or query string of the page the view is being rendered on.
It solves a small but recurring problem: Views can show you data about each row, but it has no
built-in way to reference *the page the visitor is currently looking at*. This field fills that
gap, which is most useful when you feed its value into another field's *Rewrite results* to
build a "back to this page" link, a self-referencing link, or a URL that keeps (or strips) the
current query string.

The field runs no database query — at render time it simply reads the current request path. An
**Output style** option offers seven formats: the raw internal path (like `node/215`), a raw
relative or absolute URL, the URL alias (internal, relative, or absolute), or the query string
on its own. For the query-string styles there are extra options to allow-list, rename, trim,
and lower-case individual parameters, so you can produce exactly the link fragment you need.

The module works on Drupal 9.3, 10, and 11 with no dependencies beyond core (the alias output
styles rely on core's Path module to resolve aliases). It has **no admin settings page, no
permissions, and no Drush** — everything is configured on the field itself, inside a view, so
enabling the module simply makes the field available to add.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — every output style and query-parameter option in
a table — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

1. Edit a view and, in the **Fields** section, click **Add**.
2. Search for **Global: Current path** and add it.
3. Open the field's settings and pick an **Output style**:
   - **Raw internal path** *(default)* — the system path, e.g. `node/215`.
   - **Raw relative URL** — the base path plus the internal path.
   - **Raw absolute URL** — scheme, host, and path.
   - **Alias internal / relative / absolute** — the URL alias of the current page instead of
     the internal path.
   - **Query string only** — just the query string, e.g. `nid=357&tid=271`.
4. Save.

To build a link with it, add the field, then in another field's **Rewrite results** reference
its token (`[current_path]`). For the alias-relative style you also get a **Query string
handling** option to leave, remove, replace, or concatenate the existing query string — handy
when the rewritten link needs to keep the visitor's current parameters. When you use the
concatenate mode, do **not** type a literal `?` in the rewrite; write `[current_path]tid=[tid]`
and the module inserts the correct `?` or `&` itself.

For the query-string-only style there are further options to keep only an allow-list of
parameters, rename them (`old|new`), trim trailing spaces, and lower-case values. A **per-user
cache** checkbox is available for views whose current-path output should vary by user. The full
option-by-option reference is in [`agent/configure/field.md`](../agent/configure/field.md).

## Where it lives in the admin menu

Nowhere of its own — there is no settings page. The field lives inside the Views UI, under
**Add fields → Global: Current path**, and every option is configured on the field.
