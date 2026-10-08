<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alive5 widget manager (services/widget_manager.md)

Service **`alive5.widget_manager`** → `Drupal\alive5\Alive5WidgetManager` implements
`Alive5WidgetManagerInterface` (`src/Alive5WidgetManager.php`, `src/Alive5WidgetManagerInterface.php`).
Constructor args (`alive5.services.yml`): `config.factory`, `current_route_match`, `path.current`,
`path.matcher`, `path_alias.manager`, `current_user`, `router.admin_context`, `module_handler`.

## Interface

- `isVisible(CacheableMetadata $cacheability): bool` — should the widget load on this request.
- `getWidgetSettings(): array` — `['widgetId' => trim(widget_id), 'scriptUrl' => trim(script_url),
  'elementId' => 'a5widget']` (constant `SCRIPT_ELEMENT_ID = 'a5widget'`). Fed to `drupalSettings.alive5`.

## isVisible() logic

1. Adds `alive5.settings` config as a cacheable dependency (always).
2. Early FALSE if `!enabled` or `widgetId === ''` or `scriptUrl === ''` — with **no** cache context added
   (answer is uniform site-wide, so no extra cache variation).
3. Otherwise evaluates four rules into an array and returns `!in_array(FALSE, $rules, TRUE)` — i.e. ALL
   must be TRUE. Every rule runs even after one returns FALSE, so recorded cache metadata describes the
   configured rules rather than this request's outcome.

Rules (each records the cache contexts it consults):

- `matchesUser()` — `user_visibility` anonymous/authenticated adds context `user.roles:authenticated`
  and checks `currentUser->isAnonymous()/isAuthenticated()`. Non-empty `roles` adds `user.roles` and
  requires `array_intersect(roles, currentUser->getRoles())`.
- `matchesAdminRoute()` — if `hide_on_admin`, adds `route` context and returns `!adminContext->isAdminRoute()`.
- `matchesPath()` — skipped (TRUE, no context) when mode `all` and neither hide-on-user nor hide-on-checkout.
  Otherwise adds `url.path`; hides on user pages (`/user`, `/user/*`) / checkout (`/cart*`, `/checkout*`)
  when their flags are set; then for `include`/`exclude` matches the `pages` patterns
  (`exclude` negates). Paths tested = lower-cased alias and, if different, the internal path
  (`getCurrentPaths()`); `<front>` in patterns adds `system.site` as a dependency.
- `matchesContentType()` — TRUE when `content_types` empty or `node` module absent. Else adds `route`
  context, reads the `node` route parameter, and requires it be an entity whose `bundle()` is selected
  (non-node routes → FALSE, so selecting types confines the widget to those node pages).

## Injection path

`alive5_page_attachments()` calls `isVisible()`; on TRUE attaches library `alive5/widget` and the
`drupalSettings.alive5` payload, then applies the collected cacheability to the render array unconditionally.
`js/alive5.js` (`Drupal.behaviors.alive5Widget`) reads `drupalSettings.alive5`, and if `widgetId` and
`scriptUrl` are present and no element with id `a5widget` exists, creates a `<script>` via
`document.createElement` with `.src = scriptUrl`, `.async = true`, `setAttribute('data-widget_code_id', widgetId)`,
inserting before the first script tag. This reproduces the official Alive5 embed snippet with a single-load guard.
