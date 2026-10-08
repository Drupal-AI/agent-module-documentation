# Layout Builder iFrame Modal — agent index

Renders Layout Builder edit forms (add/configure/remove block & section, move, translate)
in an **admin-themed iframe modal** instead of core's front-end off-canvas tray. Depends on
`layout_builder`. All behavior is driven by one config object with two route lists.

- **Configure it** (settings form, config object, the two route lists, drush recipes,
  permission): [configure/settings.md](configure/settings.md)
- **Call it in code** (the `IframeModalHelper` service, the AJAX/render internals):
  [api/services.md](api/services.md)
- **Theme it** (`lbim_iframe` / `lbim_redirect` theme hooks, templates, the
  `layout-builder-iframe-modal` body class): [theming/templates.md](theming/templates.md)

Quick facts:
- Config object: `layout_builder_iframe_modal.settings` — keys `layout_builder_iframe_routes`, `custom_routes`.
- Settings route: `layout_builder_iframe_modal.settings` at `/admin/config/content/layout_builder_iframe_modal`.
- Permission: `configure layout builder iframe modal`.
- No plugins, no entities, no Drush commands.
