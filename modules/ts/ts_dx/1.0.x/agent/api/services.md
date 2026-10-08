<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TS DX — services & routes

## Twig extension — `ts_dx.twig_extension`
`TwigExtension` (extends `AbstractTwigExtension`), constructor args `@theme.manager`,
`@extension.path.resolver`. Registers `TwigFunction`s prefixed `ts_` for template use
(theme/extension path helpers). Has a `::instance()` singleton accessor.

## Utility services
- `ts_dx.menu_tools` (`MenuTools`, arg `@menu.link_tree`) — menu tree helpers.
- `ts_dx.theme_tools` (`ThemeTools`, args `@router.admin_context`, `@current_route_match`).
- `ts_dx.context_tools` (`ContextTools`, args `@current_route_match`, `@entity.repository`).
- `ts_dx.misc_tools` (`MiscTools`).

## Toolbar redirect routes (`ToolbarRedirectController`)
`entityEditFormRedirect($type)` loads entities matching the request query
(`loadByProperties`, or an entity query with `accessCheck(TRUE)` when a query value is an
array of `{value,type}`), takes the last match and redirects to `entity.<type>.edit_form`,
else `system.404`. Query keys have `:` translated to `.`. Wire via an admin menu link, e.g.:
```yaml
custom_admin_menu.homepage:
  route_name: ts_dx.node_edit
  options: { query: { type: homepage } }
```
Access: `access content overview`; the destination edit form re-checks access.

## Drush
`DxCommands` (`drush.services.yml`) exposes developer CLI commands.
