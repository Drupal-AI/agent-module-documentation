# Views Node Access Filter — manual setup guide

**Views Node Access Filter** (`views_node_access_filter`) adds one Views filter,
called **Editable**, to the Content and Content revision tables. When you add it
to a view, the view only returns the nodes the **current user has permission to
edit** (update). The classic use is to make the `/admin/content` listing — or a
custom editor dashboard — show each editor only the content they can actually work
on.

There is nothing to configure centrally: the module has no settings page, no
permissions of its own, and no admin menu entry. You enable it, then add the
**Editable** filter to whichever node-based view you want to constrain. The filter
takes no operator or value and, importantly, **cannot be exposed** — so there is no
URL parameter a visitor could tamper with to weaken it. It only ever *removes*
rows, never adds them.

Under the hood it works by registering node-access edit grants that mirror
Drupal's own "edit any / edit own" permission model, so that list queries can be
filtered by edit access in SQL. It is careful not to change what anyone can *view*.
A couple of caveats apply — it works with SQL-based Views only, and it does not
reflect other access modules that change edit access purely through
`hook_node_access()` without registering grants.

This guide is written for a **human** setting this up in the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. **How to use it** — below on this page (there is no separate settings page).

## Where it lives in the admin menu

Nowhere of its own — the module has no configuration page. Its filter appears
inside the **Views UI** when you edit a node-based view.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit the view you want to restrict — for example a clone of the Content
   administration view (`/admin/content`).
3. Under **Filter criteria**, click **Add** and choose **Content: Editable** (or
   **Content revision: Editable** for a revisions view).
4. There are no options to set — the filter has no operator or value, and it is
   deliberately not exposable. Just add it and **Save** the view.

The view now lists only nodes the viewing user can edit. For an anonymous visitor
or a user with no edit rights, that simply means an empty result.

### Good to know

- **SQL Views only.** The filter throws an error on non-SQL query backends (such as
  a Search API index), so use it on standard SQL-based views.
- **View access is unchanged.** Enabling the module does not open up or restrict
  who can *view* content; it only adds an edit-access constraint to the views you
  put the filter on, and it defers to any other node-access module you run.
- **Grants stay current automatically.** The edit grants it relies on are rebuilt
  when you change a role's permissions, save a node, or enable/disable modules, so
  you do not need to rebuild permissions by hand after normal changes.
- **One caveat:** if another module grants or denies *edit* access purely through
  `hook_node_access()` without registering node grants, that difference will not be
  reflected in this filter's listing (the other module still enforces edit access
  at the entity level — this is a listing inaccuracy, not an access bypass).
