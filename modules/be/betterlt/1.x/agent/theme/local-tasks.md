<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Restyling the local task tabs

`better_local_tasks` has no UI and no config. Enabling the module is the whole configuration:
it replaces core's local-task rendering with a fixed, left-edge, icon-based slide-out panel.
All behavior lives in `better_local_tasks.module` (3 hooks), one CSS library, and two Twig
overrides. There is nothing to set via drush or PHP.

## Runtime flow (what actually happens)

1. `better_local_tasks_page_attachments_alter(&$attachments)` — attaches the
   `better_local_tasks/local-tasks` library, but **only when both** are true:
   - the current user has the core permission `access contextual links`
     (`\Drupal::currentUser()->hasPermission('access contextual links')`), and
   - the current route is **not** an admin route
     (`\Drupal::service('router.admin_context')->isAdminRoute()` is false).
   So anonymous visitors and every admin-theme page get core's default tabs — the restyle
   is front-end + editor-facing only.

2. `better_local_tasks_theme_registry_alter(&$theme_registry)` — again only when the route is
   **not** admin, repoints two theme hooks at this module's templates:
   - `block__local_tasks_block['path']` → `templates/block`
   - `menu_local_tasks['path']` → `templates/navigation`

3. `better_local_tasks_preprocess_menu_local_task(&$variables)` — adds one semantic CSS class
   to each tab's link, derived from the tab's **route name** suffix. The class is what the CSS
   uses to pick an SVG icon.

## Route-suffix → CSS class map

| Route name matches (regex) | Class added | Icon file |
|---|---|---|
| `\.canonical$` | `view` | `img/icon-view.svg` |
| `\.edit_form$` | `edit` | `img/icon-edit.svg` |
| `\.delete_form$` | `delete` | `img/icon-delete.svg` |
| `\.version_history$` | `revisions` | `img/icon-revisions.svg` |
| `\.devel_load$` | `devel` | `img/icon-devel.svg` |
| `\.content_translation_overview$` | `translate` | `img/icon-translate.svg` |
| `\.clone_form$` | `clone` | `img/icon-clone.svg` *(referenced in CSS; file not shipped in 8.x-1.4)* |
| anything else (fallthrough) | `shortcuts` | `img/icon-shortcuts.svg` |

CSS also defines `managedisplay` and `newdraft` icon classes, but the module's hook never
emits those class names — they are dormant styling for markup other modules might produce.

Note: the final branch is written `elseif ($route_name = 'shortcut.set_switch')` — a single
`=` (assignment), so it always evaluates truthy. Effect: any tab whose route matches none of
the earlier patterns is labelled `shortcuts`, not just the real shortcut-switch tab. Harmless
(it only affects which icon shows) but it is why non-standard tabs all get the shortcuts icon.

## Template overrides

- `templates/navigation/menu-local-tasks.html.twig` — renders primary/secondary tabs as
  `<ul class="blt-tabs primary">` / `<ul class="blt-tabs secondary">` with visually-hidden
  headings.
- `templates/block/block--local-tasks-block.html.twig` — extends core `block.html.twig`,
  wrapping the tabs in `<nav class="blt-tabs" role="navigation" aria-label="Tabs">`.

## CSS behavior (`css/local_tasks.css`)

The `.block-local-tasks-block` is `position: fixed; top: 50%; left: -124px` (mostly off-screen
on the left), `z-index: 9999`, and slides in on `:hover` (`left: calc(100% - 40px)`). Tabs are
dark (`#555`) list items with right-aligned SVG icons. This is a hard-coded look — restyle by
overriding these selectors in your theme.

## Turning it off / scoping it

- To disable the restyle entirely: uninstall the module (`drush pmu better_local_tasks`).
- To keep core tabs on a page: it already skips admin routes; front-end pages always get
  restyled for users with `access contextual links`. There is no per-route or per-theme
  toggle — narrowing scope means overriding the templates/CSS in your own theme.
