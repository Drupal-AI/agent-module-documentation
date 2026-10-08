# Script Manager — agent index

Registers admin-defined HTML/JS snippets as `script` config entities and injects them raw into
`page_top`/`page_bottom` on non-admin pages, gated by core condition-plugin visibility. Managed at
`/admin/structure/scripts` behind `administer scripts` (`restrict access: true`). No `configure` route
in info.yml, no Drush, no plugin types of its own; provides a config schema and one permission.

- **The `script` config entity, its fields, positions, visibility conditions, and creating one via config/Drush** →
  [configure/scripts.md](configure/scripts.md)
- **How/where snippets are rendered (page hooks, `FormattableMarkup`, admin-route skip), the `script_entity` field formatter, and `hook_script_manager_scripts_alter`** →
  [api/placement.md](api/placement.md)

Key facts:
- Permission: `administer scripts` (`restrict access: true`) — controls the whole feature. Because snippets
  are emitted **unescaped/raw**, holding this permission is equivalent to site-wide script injection; grant
  only to fully trusted roles (this is by design, not a bug).
- Config entity id `script`; config names `script_manager.script.<id>`; settings `script_manager.settings`
  (`enabled_visibility_plugins` limits which condition plugins the form offers; `{}` = all).
- Positions: `top` (`hook_page_top`), `bottom` (`hook_page_bottom`), `hidden` (never rendered).
- Scripts are never output on admin routes (`router.admin_context`).
