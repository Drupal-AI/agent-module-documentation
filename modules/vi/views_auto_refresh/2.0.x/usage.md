Views Auto Refresh periodically re-runs an Ajax-enabled View (on a timer or on demand) so its results update without a page reload, via a Views header/footer area handler plus JavaScript polling.

---

The module adds two Views area handlers exposed through `hook_views_data_alter()`: **Global: Auto Refresh** (`views_auto_refresh_area`, the primary/config area) and **Global: Auto Refresh (secondary)** (`views_auto_refresh_secondary_area`, an extra area to place the control buttons elsewhere). You add the primary area to a view's header or footer and set an `interval` (milliseconds, default 50000). Its `render()` attaches the `views_auto_refresh/views_auto_refresh` library and pushes every option into `drupalSettings.views_auto_refresh` keyed by the view's DOM id; the JS then re-triggers the view's Ajax refresh on the timer. Options include an optional user-facing toggle button (`auto_refresh_toggle_button` + enable/disable labels), a one-shot "Refresh now" button, `auto_start_refresh`, `stop_on_pagination` (pause when past page 1), accessibility helpers (`restore_focus_after_refresh`, `stop_on_focused_view_content`), and switches to suppress core Ajax side effects (`disable_ajax_scroll_top`, `disable_ajax_throbber`). Button labels are passed through `Xss::filter(..., ['span'])` so only a `<span>` (for a CSS icon) is allowed. A response subscriber (`AjaxResponseSubscriber`) strips the `scrollTop`/`viewsScrollTop` Ajax commands from the view's refresh response when `disable_ajax_scroll_top` is on (and not paging). The view must have **Use Ajax** enabled and caching disabled for refreshing to work. The JS also listens for a `RefreshView` jQuery event on the view element, so custom code can trigger a refresh on demand.

---

- Auto-refresh a dashboard view of recent orders/comments every N seconds without a full reload.
- Poll a "latest activity" or notifications view so it stays current on screen.
- Show near-real-time updates on a moderation queue or support-ticket list.
- Add a timed refresh to any Ajax view by dropping in the Global: Auto Refresh header.
- Set a custom polling interval in milliseconds per view.
- Give users an on/off toggle button to start and stop auto-refreshing themselves.
- Provide a "Refresh now" button for an immediate one-shot reload of the view.
- Auto-start refreshing on page load (or only after the user opts in via the toggle).
- Pause auto-refresh when the visitor navigates past the first page of a paginated view.
- Restore keyboard focus after a refresh so screen-reader/keyboard users aren't disrupted.
- Stop refreshing while the user's focus is inside the view content (keyboard navigation).
- Disable the default Views "scroll to top" behaviour on each refresh.
- Suppress the Ajax throbber/spinner during background refreshes.
- Use a CSS icon on the toggle/refresh buttons via an allowed `<span>` in the label.
- Place the auto-refresh control buttons in a second area (header vs footer) using the secondary handler.
- Trigger a view refresh from custom JS by firing a `RefreshView` event on the view element.
- Refresh a live scoreboard, auction, or stock/price list view.
- Keep a map or chart view backed by Views current without manual reloads.
- Build a kiosk/wallboard display that updates itself on a timer.
- Reduce server load versus full page reloads by refreshing only the view via Ajax.
- Combine auto-refresh with exposed filters while keeping the current result set live.
- Update a "who's online" or presence view periodically.
