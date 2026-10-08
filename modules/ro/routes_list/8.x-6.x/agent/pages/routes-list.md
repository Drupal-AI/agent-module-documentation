<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The routes-list report page

## Install / access
- `ddev drush en routes_list -y`. No config, no dependencies beyond core.
- Grant the `access routes list` permission (declared in `routes_list.permissions.yml`) to the roles
  that should read the report, then visit **Reports → Routes List** (`/admin/reports/routes-list`).
- Route `routes_list.report` (`routes_list.routing.yml`): `_permission: 'access routes list'`,
  `options._admin_route: TRUE`; menu link parented to `system.admin_reports`.

## Controller
`\Drupal\routes_list\Controller\RoutesListController::report()` (extends `ControllerBase`). Injected
via `create()`: `router.route_provider` (RouteProviderInterface), `user.permissions`
(PermissionHandlerInterface), `module_handler` (ModuleHandlerInterface), `entity_type.manager`
(EntityTypeManagerInterface). Returns a render array — a `#type => 'table'` (`#sticky`, `#responsive`)
with headers **Path / Route Name / Access rule** and `#empty` "No routes detected."; attaches library
`routes_list/routes_list.report`.

## What it does per route
Iterates `$this->routeProvider->getAllRoutes()`. Skips the blacklist route names `<current>`,
`<none>`, `<nolink>`. For each route it reads `$route->getRequirements()` and derives one
**access rule** cell (first match wins):

1. `_access === 'TRUE'` → red-styled "**Allowed for anyone**" (`<span class="route-full-access">`).
2. `_user_is_logged_in` present → "Any logged-in user" (TRUE) or "Only anonymous users" (else).
3. One of `_field_ui_view_mode_access`, `_field_ui_form_mode_access`, `_permission` present → looks
   the value up in `permissionHandler->getPermissions()`; if known, "Permission: @perm" where `@perm`
   is a `Link` to `user.admin_permissions` (fragment `module-<provider>`, opens in a new tab);
   otherwise "Unknown permission: &lt;key&gt;".
4. `_entity_access` present (`entity_type.op`) → "Controlled by %op access on %entity_type entity"
   (entity-type label resolved via `entityTypeManager->getDefinition(..., FALSE)`).
5. Fallback → "Custom rule" with a `title` tooltip holding `serialize($requirements)`.

## Grouping & rendering
Rows are keyed by the module inferred from the route-name prefix (`explode('.', $name, 2)`). If that
prefix is a real module, the row goes under it; special fallbacks: `/devel/*` → `devel`, `/` →
`system`; anything else lands under an "Unknown provider" section. Each module gets a bold
`routes-section` header row (`#plain_text` module name, `id="module-<module>"` so permission-page
fragments can anchor). Path cells use an `inline_template` (`{{ path }}`, Twig-autoescaped); route
name is `#markup => $name`; access-rule strings are wrapped as `#markup`.

## Notes
- The report is computed live on every request; nothing is stored. No cache metadata is set, so it
  reflects the current route table each load.
- Access-rule classification is heuristic and requirement-based — it summarizes route requirements,
  not the effective runtime access result for the current user.
- `@TODO`s in the source note the module-inference and entity/view-override handling are approximate.
