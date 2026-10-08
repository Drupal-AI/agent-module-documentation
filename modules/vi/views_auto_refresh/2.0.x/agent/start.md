# Views Auto Refresh — agent index

Periodically (or on demand) re-runs an **Ajax-enabled** View so its results update without a page
reload. Implemented as two Views area handlers + a JS library + an Ajax response subscriber. Depends
on core `views`. No config page (`configure` null), no permissions, no Drush. Config schema covers
the two area handlers' options.

- **Add the area to a view, every option key + default, the required Ajax/cache settings, the
  secondary area, and the `RefreshView` JS trigger** → [configure/views-area.md](configure/views-area.md)

Key facts:
- Area handlers (registered via `hook_views_data_alter`): `views_auto_refresh_area`
  ("Global: Auto Refresh") and `views_auto_refresh_secondary_area` ("Global: Auto Refresh (secondary)").
- Primary area `render()` attaches `views_auto_refresh/views_auto_refresh` and writes
  `drupalSettings.views_auto_refresh['views_dom_id:' . $view->dom_id]`.
- The view **must** have "Use Ajax" on and caching off. Default `interval` = 50000 ms.
- `AjaxResponseSubscriber` removes `scrollTop`/`viewsScrollTop` commands when
  `disable_ajax_scroll_top` is set (and not paginating). Button labels `Xss::filter`ed to `<span>`.
