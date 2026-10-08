# JSON:API Frontend Menu — manual setup guide

**JSON:API Frontend Menu** (`jsonapi_frontend_menu`) is an optional add-on for the
[JSON:API Frontend](https://www.drupal.org/project/jsonapi_frontend) module. It
exposes a ready-to-render menu tree over JSON:API so a decoupled front end can
draw the site's navigation without building the tree itself. Instead of fetching
raw menu links and stitching them together in the browser, you call one endpoint
and get back a nested structure — parents with their children already nested
inside them.

The endpoint does a few thoughtful things on your behalf. It filters links by the
current user's access, so a menu never "leaks" items the visitor is not allowed to
see. It can compute the **active trail** for a given page, marking which links are
active and which sit on the path to the current page. And it can emit per-link
routing hints compatible with `/jsonapi/resolve`, so your front end knows how to
turn each link into a real route. Anonymous responses are safe to cache;
authenticated responses are returned with a no-store policy.

There is nothing to configure in the admin UI — you install the module, enable it,
and call the endpoint from your front end. Everything is controlled per request
through query parameters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the endpoint responds.

## Where it lives in the admin menu

This module adds **no admin page** and has no settings form. Menu access follows
Drupal's normal menu and link access rules, so anything you would manage lives in
the usual places — **Structure → Menus** for the menus themselves, and **People →
Permissions** for who can see what. Configuration of the decoupled contract (your
Drupal URL/origin and proxy secret) is handled by the base **JSON:API Frontend**
module at **Configuration → Web services → JSON:API Frontend**.

## How to use it

Call the menu endpoint by menu machine name and ask for JSON:

```
GET /jsonapi/menu/main?_format=json
GET /jsonapi/menu/main?path=/about-us&_format=json
```

The response is a nested tree — children are already nested inside their parents,
so there is no client-side tree building to do. Several optional query parameters
tune what you get back:

- **`path`** — compute active-trail flags for the current page. Each link gains
  `active` and `in_active_trail` markers so your front end can highlight where the
  visitor is.
- **`langcode`** — forwarded to the resolver for alias and language resolution.
- **`min_depth`** / **`max_depth`** — limit how many levels of the tree are
  returned.
- **`parent`** — return only the subtree beneath a specific parent plugin ID.
- **`resolve=0`** — skip the per-link resolver decoration entirely, for maximum
  performance and cacheability when you don't need the routing hints.

Optional TypeScript helpers (`@codewheel/jsonapi-frontend-client`) and Next.js /
Astro starter templates exist to make consuming this contract easier, but they are
not required.
