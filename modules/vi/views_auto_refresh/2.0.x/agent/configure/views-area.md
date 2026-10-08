# Configure Views Auto Refresh

No admin page — everything is configured on the View itself.

## Setup (UI)

1. Edit the View and add a **header** (or footer) of type **Global: Auto Refresh**.
2. Set the refresh **Interval** (milliseconds) and toggle the options below.
3. In the View's *Advanced → Other*: set **Use Ajax = Yes** and **Caching = None**. Both are
   required — without Ajax the view cannot refresh in place, and caching would serve stale results.
4. Save. The view now refreshes on the timer (and via any buttons you enabled).

Add **Global: Auto Refresh (secondary)** as a second area (e.g. footer) only if you want the toggle /
refresh-now buttons rendered in a different spot from the primary area.

## Primary area options (`views_auto_refresh_area`)

Defaults from `defineOptions()`; schema `views.area.views_auto_refresh_area`.

| Option | Type | Default | Meaning |
|---|---|---|---|
| `interval` | string (ms) | `50000` | Polling interval in milliseconds. Must be numeric (validated). |
| `auto_refresh_toggle_button` | bool | `false` | Render an enable/disable auto-refresh toggle button. |
| `auto_refresh_button_enable_label` | string | `Enable auto refresh` | Toggle label when off. `<span>` allowed. |
| `auto_refresh_button_disable_label` | string | `Disable auto refresh` | Toggle label when on. `<span>` allowed. |
| `refresh_now_button` | bool | `false` | Render a one-shot "Refresh now" button. |
| `refresh_now_button_label` | string | `Refresh now` | Refresh-now button label. `<span>` allowed. |
| `auto_start_refresh` | bool | `false` | Start refreshing on page load. Only meaningful with the toggle button; when there is **no** toggle button the JS forces auto-start on. |
| `stop_on_pagination` | bool | `false` | Stop refreshing when not on page 1 of a paginated view. |
| `restore_focus_after_refresh` | bool | `false` | Restore focus to the previously focused element after a refresh (a11y). |
| `stop_on_focused_view_content` | bool | `false` | Pause refreshing while focus is inside `.view-content` (keyboard nav). |
| `disable_ajax_scroll_top` | bool | `false` | Remove the Views "scroll to top" Ajax command on refresh (see subscriber below). |
| `disable_ajax_throbber` | bool | `false` | Suppress the default Ajax throbber during refresh. |

`validateOptionsForm()` errors if `interval` is not numeric.

## Secondary area options (`views_auto_refresh_secondary_area`)

Only two booleans — it just renders buttons; the interval/behaviour come from the primary area.

| Option | Type | Default |
|---|---|---|
| `auto_refresh_toggle_button` | bool | `false` |
| `refresh_now_button` | bool | `false` |

## How it drives the refresh

- The primary area's `render()` attaches library `views_auto_refresh/views_auto_refresh` and writes
  all options plus `current_page` into
  `drupalSettings.views_auto_refresh['views_dom_id:' . $view->dom_id]`.
- `js/views_auto_refresh.js` (behavior `Drupal.behaviors.views_auto_refresh`) reads those settings,
  looks up `Drupal.views.instances[...]`, and on the timer triggers the view's Ajax refresh.
- Button `#value` labels are sanitized server-side with `Xss::filter($label, ['span'])` — only a
  `<span>` survives (intended for a CSS icon; add a visually-hidden span for screen readers as the
  field descriptions advise).

## Suppressing "scroll to top" (`AjaxResponseSubscriber`)

`onResponse()` runs on every response; it only acts on a `ViewAjaxResponse`. When the request is not a
pager click (`page` empty) and the view's header/footer contains a `views_auto_refresh_area` with
`disable_ajax_scroll_top` on, it strips `scrollTop` and `viewsScrollTop` commands from the response so
the page does not jump on each background refresh.

## Trigger a refresh from custom code (JS)

The behavior binds a `RefreshView` jQuery event on the view element. To force an immediate refresh
from your own script, fire it on the view's DOM element, e.g.:

```js
jQuery('.js-view-dom-id-<domId>').trigger('RefreshView');
```

This is the same event the internal "Refresh now" button uses.
