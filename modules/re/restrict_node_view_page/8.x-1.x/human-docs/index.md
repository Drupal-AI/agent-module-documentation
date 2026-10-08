# Restrict node view page access — manual setup guide

**Restrict node view page access** (`restrict_node_view_page`) controls who may open
the **full node page** (`/node/{nid}`) on a per-content-type basis, using permissions
it generates automatically for each content type. Enable it, grant the right roles
the right permission, and users without it get a `403` when they try to open the
canonical page of a restricted content type.

It provides two kinds of permission:

- **View full node pages of all content types** — a blanket permission, handy for
  staff who should reach every full page.
- **View full node pages of _(specific content type)_** — one permission generated
  per content type, so you can open up (say) *Article* full pages while keeping
  *Landing page* full pages restricted.

Under the hood it implements Drupal's `hook_node_access()` for the *view* operation:
if the user holds the blanket permission or the matching per-type permission, it
stands aside and lets normal access apply; otherwise it returns "forbidden", blocking
the full page. The check is **fail-closed** — without the permission, the page is
denied.

It is important to be precise about **what this does and does not protect**, because
it is easy to assume more than it delivers:

- **It gates the full node view page, not the node's data.** It governs the
  node-access *view* grant, which is what the canonical `/node/{nid}` page checks. It
  does **not** stop content from appearing elsewhere. Anything that renders teasers or
  individual fields through code paths that do not go through node access — many Views
  listings, some blocks, and data exposed via **REST or JSON:API** — can still surface
  the content. If your goal is to keep the content itself private, this module alone is
  not enough; pair it with matching restrictions on those other outputs.
- **`bypass node access` overrides it**, as with any node-access module. Users with
  that permission (administrators by default) always see full pages.
- A minor technical caveat: the access result does not add a `user.permissions` cache
  context, so on unusual setups be sure to test that the restriction behaves as you
  expect after cache warming.

Typical uses are keeping teaser or listing displays public while locking the detailed
page — for example brochure/detail pages restricted to authenticated users, or a
"members only" full page by role and content type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and grant the generated permissions.

There is **no configuration page** for this module — you control it entirely through
the permissions it generates, on the standard **People → Permissions** page.

## Where it lives in the admin menu

The module adds no settings form. Its permissions — the blanket "View full node pages
of all content types" and one "View full node pages of _(type)_" per content type —
appear at **People → Permissions** (`/admin/people/permissions`), where you assign
them to roles.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** and decide, per content type, which roles may open
   the full page. Grant the per-type permission (or the blanket one) accordingly.
3. Any role **not** granted the relevant permission will receive a `403` on
   `/node/{nid}` for that content type.
4. Remember to separately restrict Views, blocks, and REST/JSON:API output if the
   content must stay fully private — this module only governs the full node *page*.
