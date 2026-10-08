<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node View Redirect (node_view_redirect) — agent index

Redirects a node's canonical view page (`entity.node.canonical`) to a configured internal path, per content type. Version **8.x-1.2** (`8.x-1.x`). Core `^8 || ^9 || ^10 || ^11`. No module dependencies; no composer requirements beyond core.

## What it provides
- **Event subscriber** `Drupal\node_view_redirect\EventSubscriber\DefaultSubscriber` (service `node_view_redirect.default`, tag `event_subscriber`) — acts on `KernelEvents::REQUEST`, method `nodeViewRedirect()`. Performs the redirect.
- **Settings form** `Drupal\node_view_redirect\Form\ConfigForm` — route `node_view_redirect.config_form` at `/admin/config/workflow/node_view_redirect/config`. Menu link under `system.admin_config_workflow`.
- **Permission** `administer node view redirect` (gates the settings route only).
- **Config object** `node_view_redirect.config` (no config/install or config/schema shipped).
- **Helper** `node_view_redirect_get_content_types()` in the `.module` file — lists node bundles.

## Configuration keys (per bundle `<type>`)
- `nvr_content_type.<type>` (bool) — enable redirect for this bundle.
- `nvr_redirect.<type>` (string) — internal destination path.
- `nvr_no_exception.<type>` (bool) — force redirect for everyone, ignoring the editor-permission exemption.

## Behavior notes
- Only fires when the route name starts with `entity.node.canonical`.
- Editors are exempt unless `nvr_no_exception` is set — exemption keys off `create/edit/delete/revision` permissions for the bundle.
- Destination is admin-set config, resolved via `path.validator` + `router.no_access_checks`; an unresolvable path throws `NotFoundHttpException` (404). Current language is preserved. Watch for redirect loops when configuring.

## Solution docs
- [Configuration & redirect behavior](config/settings.md)
