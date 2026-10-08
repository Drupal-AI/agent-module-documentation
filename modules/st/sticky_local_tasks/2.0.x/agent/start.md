<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sticky Local Tasks (sticky_local_tasks) — agent index

Re-renders the page's primary local tasks (the View / Edit / Revisions / Delete tab strip) as a
fixed, collapsible widget pinned to the bottom-left or bottom-right of the viewport, so editors on
long pages reach the tabs without scrolling to the top. Pure front-end admin UX: PHP builds a render
array from the existing, already-access-checked local tasks; CSS/JS position and toggle it. No module
dependencies (the `block` usage mode uses core Block if enabled). Core `^10 || ^11`, PHP >= 8.1.

Settings form: `/admin/config/user-interface/sticky-local-tasks`
(route `sticky_local_tasks.admin_settings`). Config object: `sticky_local_tasks.settings`.
Declares one (unused) permission, no Drush, defines no plugin types.

- **Configure usage mode, position, hide-default-tabs, Gin/dark colors (form + config keys + drush/PHP)** → [configure/settings.md](configure/settings.md)
- **Who can reach the settings form (declared vs. enforced permission)** → [permissions/permissions.md](permissions/permissions.md)
- **The `sticky_local_tasks.builder` service — render the tabs from custom code** → [api/builder.md](api/builder.md)
- **`hook_sticky_local_tasks_route_alter` — map extra routes to tab icons** → [hooks/route-alter.md](hooks/route-alter.md)
- **The "Sticky primary tabs" block** → [blocks/block.md](blocks/block.md)
- **Libraries, Twig templates, theme suggestions, JS toggle, CSS variables, Gin/dark theming** → [theme/library.md](theme/library.md)

Key facts:
- Config object `sticky_local_tasks.settings`: `usage` (`all` | `block`) and the `usage_options`
  mapping — `hide_default_local_tasks`, `show_on_admin`, `remember_toggled_state`, `static_position`
  (`bottom-right` | `bottom-left`), `use_gin_colors`, `use_dark_theme` (all bool except position).
- Service id `sticky_local_tasks.builder` → `Drupal\sticky_local_tasks\StickyLocalTasksBuilder`
  (autowired); public `build(Position $position): array` and `addToPage(array &$build): void`.
- Position enum `Drupal\sticky_local_tasks\Position`: `BottomLeft` (`bottom-left`), `BottomRight` (`bottom-right`).
- Block plugin id `sticky_local_tasks` (`Sticky primary tabs`), block setting `position`.
- Libraries: `sticky_local_tasks/sticky-local-tasks` (CSS+JS), `.../hide-default-local-tasks`, `.../gin`.
- Only rendered when the current route has >= 2 visible local tasks; in `all` mode it is skipped on
  `user.login` / `user.register` / `user.pass` and (unless `show_on_admin`) on admin routes.
- Settings route is gated by core permission `administer site configuration`. The module also declares
  `administer sticky local tasks` (`restrict access: true`), but nothing enforces it — see permissions doc.
- Update hooks `sticky_local_tasks_update_10201` / `_10202` migrate 1.x config to the 2.x shape.
