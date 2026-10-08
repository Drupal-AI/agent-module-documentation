<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Classes (role_classes) — agent index

Adds **one** CSS class to `<body>`, chosen from the current user's **highest-weight role**. Not one
class per role — the single most-privileged role's class only. Configure at
`/admin/config/system/role-classes` (route `role_classes.admin_settings`, permission
`administer site configuration`). Version **1.0.7**. Core `^10.2 || ^11 || ^12`. No dependencies.

## Mechanism
- `role_classes_preprocess_html()` is a thin delegator: it calls the `role_classes.manager` service
  (`RoleClassesManager::getBodyClass()`) and, if a string comes back, appends it to
  `$variables['attributes']['class']`.
- `RoleClassesManager::resolve()` reads `role_classes.settings:class` (a `role_id => css_class` map),
  intersects it with `currentUser->getRoles()`, loads only those role entities, sorts them by weight
  **descending**, and returns the first non-empty class after `Html::cleanCssIdentifier()`. Result is
  cached per-request (three-state `null`/`false`/string).
- Config form `AdminConfigForm` (a `ConfigFormBase`) renders one textfield per role, validates each
  against `/^-?[a-zA-Z_][a-zA-Z0-9_-]*$/`, and saves the map. Default config is an empty map, so the
  module does nothing until an admin configures classes.

## Files
- `role_classes.module` — `hook_help()` (renders README), `hook_preprocess_html()`.
- `src/Service/RoleClassesManager.php` — all business logic.
- `src/Form/AdminConfigForm.php` — settings form at `role_classes.admin_settings`.
- `config/install/role_classes.settings.yml` (`class: {}`), `config/schema/role_classes.schema.yml`.
- `role_classes.permissions.yml` declares `administer role_classes settings` (restrict access), but
  the route is gated by core's `administer site configuration`, so that permission is unused by the
  shipped route.

## Say this plainly: a role class is not a way to hide anything.
A body class is a **styling hook**. CSS that hides an element hides it **visually** — the element is
still in the HTML, readable in view-source, present to a screen reader unless also removed from the
accessibility tree, and available to anything that scrapes the page. **Using it to keep content from
a role is not a weak control; it is no control, because the content was sent.**
- must not be **seen** → entity or field access;
- must not be **reachable** → a permission.

## Two points that follow from the mechanism itself
1. **The body class varies by role, but the module adds no cache context.** The preprocess hook does
   not add the `user.roles` cache context. On a page whose cache metadata does not already carry it,
   Dynamic Page Cache can serve the first authenticated visitor's class to another authenticated user
   of a different role — wrong presentation for a class-driven layout. Add `user.roles` (or use a
   role-varying block/region) if the styling matters.
2. **The class names are published.** Every visitor can read which role class the site uses for them.
   Unremarkable usually; worth a moment where the names themselves say something
   (`role--pending-investigation`).

Legitimate uses: an editorial cue that you are logged in with elevated rights, hiding a marketing
banner from staff, adjusting for the toolbar, styling a members' area.
