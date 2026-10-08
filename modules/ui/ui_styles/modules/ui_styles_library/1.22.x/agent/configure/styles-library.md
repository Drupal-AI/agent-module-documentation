<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The styles library page

Enable with `drush en ui_styles_library` (needs `ui_styles`). This submodule adds a
documentation surface only — it stores no config.

## Route and access

`ui_styles_library.routing.yml`:

- `ui_styles_library.overview` → path `/admin/appearance/ui/styles`,
  `StylesLibraryController::overview`, `_permission: access_ui_styles_library`,
  `_admin_route: FALSE` (so previews render in the front-end theme).
- `ui_suite.index` → path `/admin/appearance/ui` ("UI libraries"), a shared landing page whose
  permission ORs together the UI Suite library permissions
  (`access patterns page+access components page+access_ui_styles_library+…`).

Permission `access_ui_styles_library` ("Access styles library") is declared in
`ui_styles_library.permissions.yml`. Menu links (`ui_styles_library.links.menu.yml`) put
"Styles" under "UI libraries" under the themes page.

## Controller and rendering

`StylesLibraryController::overview()` builds:

```php
foreach ($this->stylesManager->getGroupedDefinitions() as $groupName => $defs) {
  foreach ($defs as $definition) {
    $styles[$groupName][$definition->id()] = $definition->toArray()
      + ['definition' => $definition->toArray()];
  }
}
return ['#theme' => 'ui_styles_overview_page', '#styles' => $styles];
```

The theme hook `ui_styles_overview_page` (registered in `UiStylesLibraryHooks::theme()`,
template `templates/ui-styles-overview-page.html.twig`, variable `styles`) renders each
category, style and option. `StyleDefinition::toArray()` adds `preview_options` (from
`getOptionsForPreview()`) and `render_links`, so the template can show a sample element with
each option's classes; the actual look comes from the UI Styles stylesheet generator
(`/ui_styles/stylesheet`). Disabled styles never reach the page (filtered out by the manager).
