<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Administration Theme by Content Type (admin_theme_by_content_type) — agent index

Forces the **administration theme** on the node **add/edit forms** of the content types you pick, per bundle,
instead of core's single site-wide toggle. Package `Administration`. Depends only on core **`node`**.
Core `^9 || ^10 || ^11 || ^12`. License GPL-2.0-or-later. Version dir `1.0.x` (release 1.0.0-rc1).

- **Config object, the `/admin/appearance` form alter, and the theme-swapping event subscriber** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No routes, no permissions, no plugins, no Drush, no services of note beyond two hook/subscriber classes.**
  `configure` points at core's existing `system.themes_page` (the Appearance page) — the module has no
  settings page of its own.
- One config object: **`admin_theme_by_content_type.settings`**, key **`node_bundles`** (sequence of node
  bundle machine names). Schema in `config/schema/admin_theme_by_content_type.schema.yml`.
- Hook class `AdminThemeByContentTypeHooks` (`src/Hook/`) implements
  `hook_form_system_themes_admin_form_alter` (attribute + `.module` `#[LegacyHook]` shim): adds a
  `checkboxes` element listing all node bundles to the Appearance form, plus a `#submit` handler
  (`admin_theme_by_content_type_system_themes_admin_form_submit` in the `.module`) that saves the checked
  bundles into `node_bundles`.
- Event subscriber `AdminThemeSubscriber` (`src/EventSubscriber/`, service
  `admin_theme_by_content_type.admin_theme_subscriber`) on `KernelEvents::REQUEST` priority **35**: if the
  matched route is `entity.node.edit_form` or `node.add` and the node's bundle is in `node_bundles`, it sets
  the active theme to the site admin theme (`system.theme:admin`) via `theme.manager` + `theme.initialization`.

## Mechanism (from source)

- The subscriber re-matches the request with `@router.no_access_checks` only to read the route name and
  bundle; it changes **only the active theme** and never alters page access — normal route access checking
  still runs in the kernel. Non-matching routes and non-listed bundles return early.
- Whether a given user actually sees the admin theme is still governed by core's system "View the
  administration theme" permission; the Appearance-form description links to the permissions page for that.
