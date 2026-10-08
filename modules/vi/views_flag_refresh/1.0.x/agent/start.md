# Views Flag Refresh — agent index

Views display extender that re-runs an **AJAX-enabled View** whenever a selected **Flag** link is
clicked on the page. No admin config page (`configure` null), no permissions, no Drush. Requires
`flag` + `views`. Provides config schema for the extender options.

- **Enable/configure the refresh on a display, every option, where settings live** →
  [configure/display-extender.md](configure/display-extender.md)

Key facts:
- Plugin: `ViewsDisplayExtender` id `views_flag_refresh` ("Refresh view by Flag"), shown in the display's
  *Other* section. Options: `flags` (sequence of flag ids), `noscrolltop` (0/1).
- Only fires when core **Use AJAX = Yes** on the display.
- `hook_views_pre_render()` attaches library `views_flag_refresh/refresh_ajax` and
  `drupalSettings.viewsFlagRefresh.flags[<flag_id>][<view_id>][<display_id>] = true`.
- `RequestSubscriber` (event subscriber) adds a `viewsFlagRefresh` AJAX command on the
  `flag.action_link_flag`/`flag.action_link_unflag` routes, and removes `scrollTop`/`viewsScrollTop`
  commands from `views.ajax` responses when `noscrolltop` is set.
- Settings stored in the View: `display_options.display_extenders.views_flag_refresh`
  (schema `views.display_extender.views_flag_refresh`).
