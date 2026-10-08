<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & redirect behavior

## Install / enable
`drush en node_view_redirect -y`. No dependencies beyond Drupal core (`^8 || ^9 || ^10 || ^11`). Nothing else to set up; there is no config/install default, so the `node_view_redirect.config` object is created on first save of the settings form.

## Settings form
- Route: `node_view_redirect.config_form` → `/admin/config/workflow/node_view_redirect/config` (`_admin_route: TRUE`).
- Permission: `administer node view redirect`.
- Class: `Drupal\node_view_redirect\Form\ConfigForm` (extends `ConfigFormBase`); form id `node_view_redirect_config_form`; editable config `node_view_redirect.config`.
- Renders a `#type => table` with one row per node bundle (bundles come from `node_view_redirect_get_content_types()`), three columns:
  - **Content type** — checkbox → `nvr_content_type.<type>`.
  - **Redirect path** — textfield → `nvr_redirect.<type>` (shown when the row's checkbox is checked, via `#states`).
  - **No permission exception** — checkbox → `nvr_no_exception.<type>`.
- `validateForm()`: if a bundle is checked its path may not be empty, and the path must resolve via `router.no_access_checks`->`match($url)` (private `urlIsValid()`); otherwise a form error is set. So only paths that map to a real internal route can be saved.

## Config object `node_view_redirect.config`
Per bundle `<type>` (e.g. `article`, `page`):
- `nvr_content_type.<type>` — bool, redirect enabled for this bundle.
- `nvr_redirect.<type>` — string, destination internal path.
- `nvr_no_exception.<type>` — bool, force redirect for all users.

No config schema file ships with the module.

## Redirect logic — `DefaultSubscriber::nodeViewRedirect()`
Service `node_view_redirect.default`, subscribed to `KernelEvents::REQUEST`. Injected: `config.factory`, `current_route_match`, `language_manager`, `current_user`, `router.no_access_checks`, `path.validator`.

Flow:
1. `isNodeRoute()` — return unless the current route name starts with `entity.node.canonical` (`strpos(...) === 0`).
2. Get the `node` route parameter; if numeric, `Node::load()`. Proceed only for a `NodeInterface`.
3. Determine `$typeName = $node->bundle()`.
4. Editor exemption `$has_permission`:
   - If `nvr_no_exception.<type>` is truthy → `$has_permission = FALSE` (no exemption; everyone is redirected).
   - Otherwise `$has_permission = TRUE` if the current user holds any of: `create <type> content`, `delete any <type> content`, `delete own <type> content`, `delete <type> revisions`, `edit any <type> content`, `revert any <type> revisions`, `view <type> revisions`.
5. If `nvr_content_type.<type>` is enabled **and** `!$has_permission`:
   - `$dir = nvr_redirect.<type>`.
   - If `path.validator->isValid($dir)` is false → throw `NotFoundHttpException` (404).
   - Else `router.no_access_checks->match($dir)` → build `Url::fromRoute($result['_route'], $result['_raw_variables']->all(), ['language' => $currentLanguage])` and `$event->setResponse(new RedirectResponse(...))`.

The destination is taken only from admin-saved config and is resolved to an internal Drupal route; the interface language is carried onto the redirect.

## Operating notes
- To enable: check the content type on the settings form and enter a valid internal path (e.g. `/node/1`, `/some-view-page`).
- To disable a bundle: uncheck it (the `nvr_content_type.<type>` flag).
- "No permission exception" makes the redirect apply to editors too — otherwise editors/authors of that bundle keep seeing the node.
- A configured path that later stops resolving produces a 404 for redirected users; review paths after route or content changes.
- Avoid pointing a bundle's redirect at a path that resolves back to that same node's canonical route (redirect loop).
