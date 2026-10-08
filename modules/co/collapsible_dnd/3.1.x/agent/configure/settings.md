# Configuring Collapsible DnD

## Settings form

Route `collapsible_dnd.settings` → `/admin/config/user-interface/collapsible-dnd` (menu link under
*Configuration › User interface*), form `\Drupal\collapsible_dnd\Form\CollapsibleDndConfigForm`,
gated by permission **`administer collapsible dnd settings`**. Edits the config object
`collapsible_dnd.settings`.

## Config keys (`collapsible_dnd.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `route_patterns` | string | `''` | Newline-separated route names; `*` = wildcard (zero+ chars). Empty = run everywhere. Lines starting `#` and blank lines are ignored. |
| `negate_route_patterns` | bool | `false` | `false` → patterns are an **exclusion** list (run everywhere *except* matches). `true` → **allow** list (run *only* on matches). Only meaningful when `route_patterns` is non-empty. |
| `expand_all` | bool | `false` | Show an "Expand all" toolbar button. |
| `collapse_all` | bool | `false` | Show a "Collapse all" toolbar button. |
| `search` | bool | `false` | Show a per-table search box. |

Set via UI or e.g.
`drush config:set collapsible_dnd.settings expand_all true -y`.

## Route-matching logic (`CollapsibleDndSettings`)

Service `collapsible_dnd.settings` (`src/CollapsibleDndSettings.php`, arg `@config.factory`):

- `getRoutePatterns()` — splits `route_patterns` on any newline, trims, drops empties and `#`
  comments.
- `isRouteEnabled(?string $route_name)`:
  - No patterns → `TRUE` (enabled on every route).
  - Patterns present but route name empty → `FALSE`.
  - Otherwise each pattern is turned into a regex (`preg_quote` then `\*` → `.*`, anchored `^…$`)
    and matched against the route name; result is negated unless `negate_route_patterns` is TRUE.
- `getJavascriptSettings(?route)` returns
  `['enabled' => isRouteEnabled(route), 'expandAll' => …, 'collapseAll' => …, 'search' => …]`.

## How it reaches the browser

- `hook_library_info_alter` appends `collapsible_dnd/collapsible_draggables` to the dependencies of
  core `drupal.tabledrag`, so the JS/CSS load automatically on any page with a draggable table.
- `hook_page_attachments` attaches `drupalSettings.collapsibleDnd = getJavascriptSettings(current
  route)`.
- `hook_preprocess_html` adds a `theme-<admin_theme_name>` class to `<body>` on admin routes so the
  CSS can match the active admin theme.

Library `collapsible_dnd/collapsible_draggables` = `js/collapsible_dnd.js` + `css/collapsible_dnd.css`,
depending on `core/drupal`, `core/drupalSettings`, `core/once`.
