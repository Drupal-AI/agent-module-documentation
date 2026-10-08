<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring bundle/role view rules

## Where
`/admin/config/people/content-view-access` — permission `administer content view access` in routing (see caveat below).

## What you set
For every node type and taxonomy vocabulary, a select per role with actions:
- `''` — None (default behavior).
- `403` — throw AccessDeniedHttpException.
- `404` — throw NotFoundHttpException.
- `front` — RedirectResponse to `/`.
- `blank` — empty 200 Response.

Saved to `content_view_access.settings` as `access[node|taxonomy_term][bundle][role_id] = action`. Only non-empty actions are stored.

## How enforcement works (and its limits)
`ContentViewAccessSubscriber::onRequest()` (priority 32) runs on the incoming request. It only matches routes `entity.node.canonical` / `entity.taxonomy_term.canonical`, resolves the entity, and for each of the user's roles applies the first configured action for that entity_type+bundle.

Because it hooks the request rather than Drupal's access system, it does NOT gate:
- JSON:API (`/jsonapi/node/...`) or REST (`/node/{nid}?_format=json`),
- Views listings, search results, RSS feeds,
- edit/delete/revision routes or entity references/embeds.

For real protection implement/enable a module that provides `hook_node_access` or node access grants.

## Known config caveats
- Route requires permission `administer content view access`, but `permissions.yml` declares `administer bundle access`; grant does not match route → only user 1 can open the form until the machine names are aligned.
- `.module` contains empty legacy `hook_menu()`/`hook_permission()` stubs (no effect).
