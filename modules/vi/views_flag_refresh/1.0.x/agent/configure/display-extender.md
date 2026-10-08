# Configure flag-driven refresh on a View

No global settings page (`configure` null). Configuration is entirely per **View display** via the
`views_flag_refresh` display extender.

## Turn it on (UI)

1. Edit the View, pick the display.
2. In **Other** set **Use AJAX** = *Yes* (required — the refresh only runs on AJAX displays).
3. In **Other** click the value next to **Refresh view by Flag**.
4. Tick the flag(s) under *Refresh display on flags* that should trigger a refresh.
5. Optionally tick *Disable scroll to top of this view* to suppress the post-refresh jump.
6. Apply and save; clear cache.

The flag options list is every flag from `\Drupal::service('flag')->getAllFlags()`.

## Options (from `defineOptions()`)

| Option | Type | Default | Meaning |
|---|---|---|---|
| `flags` | array of flag ids | `[]` | Which flags trigger a refresh of this display (`array_filter`ed on save). |
| `noscrolltop` | int (0/1) | `0` | When 1, strips `scrollTop`/`viewsScrollTop` AJAX commands so the page doesn't scroll after refresh. |

## Where it is stored

```yaml
# views.view.<id> → the display:
display_options:
  display_extenders:
    views_flag_refresh:
      flags:
        my_flag: my_flag
      noscrolltop: 1
```

Schema: `views.display_extender.views_flag_refresh` (`flags` sequence of strings, `noscrolltop` integer).

## How the runtime wiring works (no code needed)

- `hook_views_pre_render()` checks the display has `use_ajax` and the extender has non-empty `flags`,
  then attaches library `views_flag_refresh/refresh_ajax` and
  `drupalSettings.viewsFlagRefresh.flags[<flag_id>][<view_id>][<current_display>] = TRUE`.
- On a flag/unflag AJAX click (`flag.action_link_flag` / `flag.action_link_unflag`),
  `RequestSubscriber::onResponse()` appends the `viewsFlagRefresh` command with the flag id.
- `js/views-flag-refresh.js` handles that command: for each `Drupal.views.instances` whose
  name+display match the settings map, it calls the view's refresh AJAX (or re-triggers the exposed
  form). It also caches `exposedFormAjax` so exposed-filter views can be refreshed.

## Gotchas

- If nothing refreshes: confirm *Use AJAX* is Yes, the flag is ticked in **this** display, and cache is
  cleared. The settings map is keyed by view id + display id, so the flag link and the View must render
  on the same page.
- `noscrolltop` only affects this View's own AJAX responses (matched via the extender on `views.ajax`).
