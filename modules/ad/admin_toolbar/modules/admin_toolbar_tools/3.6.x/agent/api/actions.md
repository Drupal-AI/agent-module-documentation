# Action routes

All handled by `Controller/ToolbarController.php`, requirement
`_permission: administer site configuration` + `_csrf_token: TRUE` (so they must be reached
via a token-signed link, e.g. the toolbar item — not a bare GET).

| Route | Path | Action |
|---|---|---|
| `admin_toolbar_tools.flush` | `/admin/flush` | Flush all caches. |
| `admin_toolbar_tools.cssjs` | `/admin/flush/cssjs` | Flush CSS/JS aggregates. |
| `admin_toolbar_tools.plugin` | `/admin/flush/plugin` | Clear plugin caches. |
| `admin_toolbar_tools.flush_static` | `/admin/flush/static-caches` | Clear static caches. |
| `admin_toolbar_tools.flush_menu` | `/admin/flush/menu` | Rebuild menu cache. |
| `admin_toolbar_tools.flush_rendercache` | `/admin/flush/rendercache` | Clear render cache. |
| `admin_toolbar_tools.flush_views` | `/admin/flush/views` | Clear Views cache. |
| `admin_toolbar_tools.flush_twig` | `/admin/flush/twig` | Clear compiled Twig. |
| `admin_toolbar_tools.theme_rebuild` | `/admin/flush/theme_rebuild` | Rebuild theme registry. |
| `admin_toolbar.run.cron` | `/run-cron` | Run cron now. |

Extra add-content / bundle / manage links are generated dynamically by
`Plugin/Derivative/ExtraLinks.php` based on the entity types and bundles on the site.
