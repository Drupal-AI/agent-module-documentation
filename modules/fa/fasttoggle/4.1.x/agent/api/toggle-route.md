<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `fasttoggle.toggle` route and controller

Route (`fasttoggle.routing.yml`):

```yaml
fasttoggle.toggle:
  path: '/fasttoggle/{entity_type}/{entity_id}/{action}'
  defaults:
    _controller: '\Drupal\fasttoggle\Controller\FasttoggleController::toggle'
  requirements:
    _permission: 'use fasttoggle'
```

Controller: `FasttoggleController::toggle(Request $request)` in
`src/Controller/FasttoggleController.php` (extends `ControllerBase`).

## How it reads parameters

Rather than using the named route slugs directly, `toggle()` splits
`$request->getPathInfo()` on `/`, finds the `fasttoggle` segment, and reads the next three parts as
`$type`, `$id`, `$action`. It validates the segment count (accepts 4–6 parts) and returns a plain
`Response` with HTTP 400 if the count is wrong.

## Supported type/action combinations

- `type = node`: loads the node via the `node` storage handler.
  - `action = status` → publish/unpublish (`isPublished()` → `setPublished()` / `setUnpublished()`),
    selector `.fasttoggle-node-status`.
  - `action = promote` → `setPromoted(!isPromoted())`, selector `.fasttoggle-node-promote`.
  - `action = sticky` → `setSticky(!isSticky())`, selector `.fasttoggle-node-sticky`.
  - After the switch, `$node->save()`.
- `type = comment`: loads the comment via the `comment` storage handler.
  - `action = status` → publish/unpublish, selector `.fasttoggle-comment-{id}-status`; then `$comment->save()`.
- Any other `type` → HTTP 400 `Invalid entity type.`
- A non-loadable `$id` → HTTP 400 `Invalid entity ID.`

Only these hard-coded properties are handled; there is no user toggle in 4.1.x.

## Response

On success the controller returns an `AjaxResponse` containing a single
`ReplaceCommand($selector, $data)`, where `$data` is a new `<a class="use-ajax …">` link whose label
reflects the just-applied state (see the label style in [../config/settings.md](../config/settings.md)).
This is what lets the link update in place after a click without a full page reload. The link markup
mirrors what the hooks generate for the initial page render (see
[../hooks/links-and-bundle-settings.md](../hooks/links-and-bundle-settings.md)).

## Access

The route requires the `use fasttoggle` permission. Grant it only to trusted content-moderation
roles that should be able to change published/promoted/sticky state on the bundles where fasttoggle
is enabled, and keep `administer fasttoggle` (the settings form) to site administrators.
