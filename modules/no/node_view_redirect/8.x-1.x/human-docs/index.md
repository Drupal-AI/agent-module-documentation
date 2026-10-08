# Node View Redirect — manual setup guide

**Node View Redirect** (`node_view_redirect`) redirects a node's view page to an
**existing path**, configured per content type. Some content types exist mainly as data
behind a canonical URL that should really point somewhere else — a landing entry that
should open a campaign page, or a record that should send visitors to a related page
rather than render its own node view. This module makes the node's view route redirect
to a path you choose for that content type.

The redirect target is **admin‑configured, not derived from the request**, so it is not
an open‑redirect surface. It plays no content or access‑control role of its own — it
simply routes the view page elsewhere. When you set it up, confirm the targets match
your intent, don't create redirect loops, and don't send users away from content they
are meant to see.

There is no central settings form; the redirect is configured per content type. Enable
the module, then set the target path on the content types that should redirect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — the redirect target is set per content
type, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types** (`/admin/structure/types`) and edit the content
   type whose node view should redirect.
3. Set the **existing path** that nodes of this type should redirect to.
4. Save, then visit a node of that type — you should be redirected to the configured
   path. Check that the redirect makes sense and does not loop.
