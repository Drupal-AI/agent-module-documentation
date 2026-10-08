# The Tools menu and the links it adds

The module has **no settings form** — `configure` is null and there is no `config/install`
or `config/schema`. Its "configuration" is the set of menu links it registers on the core
Navigation admin menu (`menu_name: admin`). Links come from
`navigation_extra_tools.links.menu.yml` plus the `ToolsMenuDeriver` plugin deriver
(`navigation_extra_tools.extra_links`). All action routes are CSRF-protected
(`_csrf_token: 'TRUE'`) and handled by
`NavigationExtraToolsController`, which runs the operation, adds a status message, and
redirects back to the current page.

## Top-level

| Menu link | Route | Path | Action |
|---|---|---|---|
| Tools (parent) | `navigation_extra_tools.overview` | `/admin/tools` | Menu block page (custom access) |
| Flush all caches | `navigation_extra_tools.flush` | `/admin/flush` | `drupal_flush_all_caches()` |
| Flush individual cache (parent) | `navigation_extra_tools.individual` | `/admin/tools/individual` | Menu block page |
| Run cron | `navigation_extra_tools.run.cron` | `/run-cron` | `cron->run()` |
| Run updates | `system.db_update` | (core) | Core database-updates page |

## Individual cache flushes (under "Flush individual cache")

| Menu link | Route | Path | Controller method |
|---|---|---|---|
| Flush CSS and JavaScript | `navigation_extra_tools.css_js` | `/admin/flush/css-js` | `flushJsCss()` (`asset.query_string` reset) |
| Flush plugins cache | `navigation_extra_tools.plugin` | `/admin/flush/plugin` | `flushPlugins()` |
| Flush static cache | `navigation_extra_tools.flush_static` | `/admin/flush/static-caches` | `flushStatic()` (`drupal_static_reset()`) |
| Flush routing and links cache | `navigation_extra_tools.flush_menu` | `/admin/flush/menu` | `flushMenu()` (menu cache + rebuild) |
| Flush twig cache | `navigation_extra_tools.flush_twig` | `/admin/flush/twig` | `flushTwig()` |
| Flush render cache | `navigation_extra_tools.flush_render_cache` | `/admin/flush/render-cache` | `cacheRender()` |
| Rebuild theme registry | `navigation_extra_tools.theme_rebuild` | `/admin/flush/theme_rebuild` | `themeRebuild()` |

(There is also a `flushViews()` method / `navigation_extra_tools.flush_views` route at
`/admin/flush/views` calling `views_invalidate_cache()`.)

All flush routes require the `access navigation extra tools cache flushing` permission; the
cron route requires `access navigation extra tools cron`. See
[permissions](../permissions/navigation_extra_tools.md).

## Conditional sections (added by the deriver)

- **Development** (`navigation_extra_tools.devel`, `/admin/tools/devel`) — appears only when
  the **Devel** module is enabled. Its child links mirror the items selected in the Devel
  Toolbar settings at `/admin/config/development/devel/toolbar` (Devel's own config object
  `devel.toolbar.settings`, key `toolbar_items`); `devel.cache_clear` and `devel.run_cron`
  are skipped as duplicates. Adds **Webprofiler settings** when `webprofiler` is enabled and
  **Execute PHP Code** when `devel_php` is enabled. When Devel is first installed,
  `hook_modules_installed()` calls `DevelMenu::enableInitialOptions()` to seed the initial
  toolbar selection (matching the hard-coded Admin Toolbar Extra Tools list).
- **Project Browser** (`navigation_extra_tools.project_browser`, `/admin/project_browser`) —
  appears only when the **project_browser** module is enabled; includes a **Clear storage**
  link (`/admin/project_browser/clear`) gated by `access project browser clear storage`.
