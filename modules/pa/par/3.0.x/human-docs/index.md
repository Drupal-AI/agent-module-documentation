# Personal Access Restriction — manual setup guide

**Personal Access Restriction** (`par`) lets you hide an individual **node's or
term's page** from chosen users or roles, configured right on that entity's edit
form. It answers a common, small requirement: one page a particular role shouldn't
see, a term listing that's for staff only, a handful of nodes kept from a group —
without building out core's full node-access system (grants, a rebuild, and a
mental model most site builders would rather not take on for three pages). A
per-entity checkbox is far more approachable, and you can choose whether a blocked
visitor gets an **"Access denied" (403)** or a **"Page not found" (404)** response.

It provides three permissions — **Configure all Personal Access Restrictions**,
**Manage Personal Access Restriction**, and **View restricted pages** (the last is
a site-wide bypass) — and supports Drupal 8 through 11.

**Please read this before relying on it — the scope is much narrower than the name
"User access" suggests.** Personal Access Restriction implements **no entity access
hook of any kind**: no `hook_node_access()`, no grants, no query alter. Its entire
enforcement happens in the theme layer, during the full-page render of the node or
term page. That has one big consequence: `$node->access('view')` is never touched,
so **everything else that asks Drupal that question still serves the content
normally** — JSON:API, REST, Views listings, search results, teasers, RSS/feeds,
sitemaps, related-content blocks, and the node's own `edit`/`revisions`/`delete`
routes. Two smaller notes: the decision carries no cache context (nothing tells
Drupal the page varies by user), and the `administrator` role is matched by its
machine name rather than checked as a permission.

So treat this module as a **presentation feature** — "do not show this page at this
URL" — and **never as confidentiality**. For genuine access control, use core's
node access system or a module that implements access grants.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no module-wide settings form to fill in; setup is entirely **permissions**
plus **per-entity** restriction fields, described in "How to use it" below. A
central page at `/admin/config/par` lists and filters the restrictions you have
created.

## Where it lives in the admin menu

- **Restrictions overview:** **Configuration → Personal Access Restriction**
  (`/admin/config/par`) lists every restriction, with filters by entity type,
  entity ID, UID, user role, and action.
- **Permissions:** **People → Permissions** (`/admin/people/permissions`,
  `#module-par`).
- **Per-page setup:** the **Personal Access Restriction** container on each node's
  or term's add/edit form.

Reaching the top-level admin category requires the module's configure permission.

## How to use it

1. **Grant permissions.** At **People → Permissions**, assign
   **Configure all Personal Access Restrictions**, **Manage Personal Access
   Restriction**, and (optionally) **View restricted pages** to the appropriate
   roles. Users with the `administrator` role always see restricted pages.
2. **Restrict a page.** Edit the node or term you want to hide. Expand the
   collapsed **Personal Access Restriction** container:
   - **User ID** — enter one or more UIDs (separated by whitespace) to restrict the
     page for those specific users.
   - **Roles** — select role(s) to restrict the page for everyone in those roles.
   - **How to show the page?** — choose the response for blocked visitors:
     *Access denied* (403) or *Page not found* (404). There is also a default
     option you can leave selected if you want to record users/roles now but not
     actually restrict access yet.
3. **Save** the entity. The chosen visitors now get your selected response when
   they open that page directly.
4. **Review restrictions** anytime at **Configuration → Personal Access
   Restriction** (`/admin/config/par`), filtering to find a specific restriction.

> **Reminder:** This only hides the rendered page at its URL. The same content can
> still surface through Views, search, JSON:API/REST, feeds, and teasers. Do not
> use it to protect anything that must stay confidential.
