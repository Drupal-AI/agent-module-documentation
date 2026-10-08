# Me Redirect — manual setup guide

**Me Redirect** (`me_redirect`) gives your site a stable set of **`/me` paths** that always
point at the currently logged‑in user's own account pages. Linking to "your account" would
normally require knowing the current user's ID, which templates and static links do not
always have. With this module you can just link to `/me`, `/me/edit`, and so on, and each
request is redirected to that user's real page — `/me` → `/user/123`, `/me/edit` →
`/user/123/edit`.

The redirect is a **302** (temporary) by design, so the behavior can be changed later
without links being cached permanently. The target is derived **server‑side from the
session**, never from anything in the request, so `/me` always means the authenticated
user — it cannot be pointed at another user's pages and is not an open redirect. For
anonymous visitors `/me` has no target, and they are sent to log in as normal.

It is a small convenience/routing helper with no unusual security surface and nothing to
configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for Me Redirect — it works the moment you enable it,
with no settings to adjust.

## Where it lives in the admin menu

Me Redirect adds no admin page and no settings form. Once enabled, the `/me` paths simply
work for any logged‑in user.

## How to use it

After enabling the module, use the `/me` paths anywhere you would otherwise need the current
user's account URL:

- `/me` → the logged‑in user's profile (`/user/UID`)
- `/me/edit` → their account edit form (`/user/UID/edit`)
- `/me/*` → the corresponding `/user/UID/*` page

These are ideal for menu links, template links, or documentation where the URL must work for
whoever is signed in. Anonymous users following a `/me` link are redirected to log in.
