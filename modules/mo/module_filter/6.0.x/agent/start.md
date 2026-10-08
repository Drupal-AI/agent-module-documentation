# module_filter — agent start

Admin-usability tool: adds an instant client-side filter (and optional server-rendered tabbed layout)
to the Extend page, update status report, uninstall/confirm forms, and permissions page.
Core `system` only — **no jQuery, no contrib dependency** (vanilla-JS rewrite on 6.0.x).
Requires **Drupal ^11.4 || ^12**.
Config UI: **Admin → Config → User interface → Module filter**
(`/admin/config/user-interface/module-filter`, route `module_filter.settings`).

- Settings keys, tabs, filter operators, affected pages → [configure/settings.md](configure/settings.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)

## Diff 5.0.x → 6.0.x (major bump — BC breaks)
- **Dependency dropped.** 5.0.x required contrib `jquery_ui_autocomplete` (`^2.1`); 6.0.x has **no
  `dependencies:` in `.info.yml` and no Composer requires** — the filter is a from-scratch vanilla-JS
  implementation ("Nothing, not even jQuery!"). Sites that pulled in `jquery_ui_autocomplete` only via
  module_filter no longer get it.
- **Drupal 10 support removed.** `core_version_requirement` narrowed from `^10 || ^11 || ^12` to
  `^11.4 || ^12` (minimum D11.4).
- **Fully OOP hooks.** Hooks now use the `#[Hook]` attribute across three classes
  (`Hook\ModuleFilterFormHooks`, `Hook\ModuleFilterHooks`, `Hook\ModuleFilterThemeHooks`) plus a
  static-callback service `Services\ModuleFilterHelper`. **No `.module` file / no `#[LegacyHook]`
  shim** — any code referencing procedural `module_filter_*` hook functions breaks.
- **Server-rendered tabs.** Tabbed Extend layout is now built server-side via a new theme hook
  `module_filter_modules_tabs` + `templates/module-filter-modules-tabs.html.twig` (JS enhances the
  pre-rendered DOM instead of constructing it).
- **Update-status filter via controller override.** A `RouteSubscriber` re-points the `update.status`
  route controller to `Controller\ModuleFilterUpdateController`, which prepends the filter form.
- Config schema/keys unchanged (`tabs`, `path`, `descriptions_show`, `enabled_filters.permissions`).
