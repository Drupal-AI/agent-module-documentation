<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Libraries report page

Libraries UI has **no settings form** — the `configure` route points at the report itself.

| Thing | Value |
|---|---|
| Route | `libraries_ui.overview` |
| Path | `/admin/reports/libraries` |
| Menu | under *Reports* (`system.admin_reports`), weight 100, title "Libraries" |
| Access | permission `access libraries_ui` (`_admin_route: TRUE`) |
| Controller | `LibrariesUiController::libraries()` |
| Render | `#theme => 'libraries_ui'`, `#libraries => LibrariesUiService::getAllLibraries()` |

## What you see

A collapsible list: one `<details>` per extension (module/theme/core), and inside it each library
name with its properties (version, css/js file entries, dependencies, license, whether assets are
minified). Template: `templates/libraries-ui.html.twig` (theme hook `libraries_ui`, variable
`libraries`).

## Theme hook

```php
libraries_ui_theme(): ['libraries_ui' => ['variables' => ['libraries' => NULL]]]
```

Override `libraries-ui.html.twig` in your theme to customise the report layout. There is no config to
export; the page is computed live from library discovery each request.
