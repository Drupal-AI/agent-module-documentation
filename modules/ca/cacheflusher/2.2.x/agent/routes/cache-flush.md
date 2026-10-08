<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache flush route, permission & controller

The entire module is one route, one controller method, one permission, one menu link, one library,
and one `hook_page_attachments()`.

## Install / enable
- `drush en cacheflusher` (or enable via Extend). No dependencies (`cacheflusher.info.yml` lists
  none), no configuration step, no config schema.
- Grant the permission `access cache flusher` to the roles that should see/use the button
  (Admin > People > Permissions, or `drush role:perm:add <role> 'access cache flusher'`).
- The button appears in the admin menu/toolbar under Administration (menu link parent
  `system.admin`).

## Route
`cacheflusher.routing.yml`:
- id `cacheflusher`, path `/admin/cacheFlusher` (note the capital F).
- `_controller`: `Drupal\cacheflusher\Controller\CacheFlusherController::cacheFlusherCacheClear`.
- `requirements`: `_permission: 'access cache flusher'`.
- The route is a direct link action: requesting the path performs the flush immediately and then
  redirects, so it is invoked by clicking the menu link rather than submitting a form.

## Controller
`src/Controller/CacheFlusherController.php`, `CacheFlusherController extends ControllerBase`,
method `cacheFlusherCacheClear()`:
1. `drupal_flush_all_caches();` — rebuilds every cache bin and the service container (a full,
   expensive flush; equivalent to `drush cr`).
2. `$this->messenger()->addMessage(t('All Caches cleared. '));`
3. `$previousUrl = \Drupal::request()->server->get('HTTP_REFERER');`
4. `return new RedirectResponse($previousUrl);` — sends the user back to the referring page.

There is no config read/write, no database query, no external HTTP call, and no user input parsed
beyond the browser-supplied `Referer` used for the redirect.

## Permission
`cacheflusher.permissions.yml` defines a single permission:
- `access cache flusher` — title "Access cacheFlusher", description "Allows users to access the
  cacheFlusher". It is a plain permission (no `restrict access: true`). Because the route only
  requires this permission, any role holding it can trigger a full cache flush.

## Menu link
`cacheflusher.links.menu.yml`:
- id `cacheflusher`, title "CacheFlusher", `route_name: cacheflusher`, parent `system.admin`,
  weight 1. This is what places the clickable entry in the admin toolbar/menu.

## Styling / assets
- `cacheflusher.libraries.yml` defines `cacheflusher-styling`, a theme CSS asset
  `presentation/cacheflusher.icons.theme.css` (compiled from `.scss`) that renders the reload icon.
- `cacheflusher.module` implements `cacheflusher_page_attachments(&$attachments)` which attaches
  `cacheflusher/cacheflusher-styling` to **every** page (not just the route).
- Icon source files: `presentation/icons/000000/reload.{svg,png}` (black) and
  `presentation/icons/787878/reload.{svg,png}` (grey).

## Operating notes
- The flush is site-wide and expensive: it clears all bins and rebuilds the container, so the whole
  site rebuilds caches afterward (transient performance cost). Grant `access cache flusher` only to
  trusted admin/developer roles.
- After the flush the user is redirected to the page named in the `Referer` header; if that header
  is absent (e.g. direct navigation to `/admin/cacheFlusher`), the redirect target is empty.
