# User current paths — manual setup guide

**User current paths** (`user_current_paths`) adds stable, UID‑neutral URLs for
the logged‑in user, so you can link to "the current user's account pages" without
knowing their user id or writing any code. It provides `/user/edit`,
`/user/current`, and `/user/current/{action}`, each of which simply redirects to
the equivalent `/user/{uid}/…` page for whoever is logged in. It also adds a
handy **"Edit my account"** link to the account menu.

The value is convenience for menus, blocks, and templates. Instead of building a
custom controller just to send someone to their own edit form, you can point a
menu link, a call‑to‑action, or a post‑login destination at the fixed path
`/user/edit` and it works for every user. Likewise `/user/current` resolves to the
current user's profile (`/user/{uid}`), and `/user/current/edit`,
`/user/current/cancel`, and similar resolve to the matching action pages. Because
the links are UID‑neutral, they keep working across environments where user ids
differ, such as staging versus production.

It is safe by design. All three routes require the visitor to be logged in, so
anonymous users never see broken links. Each redirect target is validated against
Drupal's real routes and access checks before the redirect happens — if the target
is invalid or the user is not allowed to see it, they get a normal 404 rather than
being sent somewhere they should not go.

This is a tiny, zero‑configuration convenience module. It depends only on core's
**User** module and has no settings form, permissions, or plugins of its own. It
supports Drupal 8.9 through 11.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — including the exact routes and
redirect logic — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no admin page to configure. Once enabled, the module registers its
UID‑neutral routes and adds an **"Edit my account"** link to the **account** menu
for logged‑in users. You can manage or reposition that menu link like any other
under **Structure → Menus → Account menu**.

## How to use it

Just link to the stable paths wherever you build navigation:

- `/user/edit` — the current user's own edit form.
- `/user/current` — the current user's profile page (`/user/{uid}`).
- `/user/current/{action}` — a routed sub‑page for the current user, for example
  `/user/current/edit` or `/user/current/cancel`.

Use these in menus, blocks placed for authenticated users, Twig templates, or as a
post‑login redirect destination, and each visitor is sent to their own pages
automatically.
