<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Display switch area

No global settings page. Everything lives on the Views area handler.

## Add it to a view

1. Edit a view in the Views UI.
2. In **Header** or **Footer**, click *Add* and choose **Display switch** (Global group).
3. In the handler options, tick each display under **Displays** you want a link for and set a
   **Label** for each (label is required when the display is enabled).
4. Save the view. The links render wherever the area was placed, for every display that
   includes the area.

Only **page (path-based)** and **block** displays appear in the list; attachment/feed/embed
displays are excluded. If a view has no eligible displays you get *"There are no path-based or
block displays available."*

## How the links are built (`DisplaySwitch::render()` / `getDisplayLink()`)

- **Page display** → `Url` from the target display's own path (`$view->getUrl(args, display_id)`),
  with the current exposed input + current pager page copied into the query string.
- **Block display** (no path) → link to the **current path** with query
  `?mode=<display_id>` (plus the copied exposed input / page). Core internal Views request keys
  (`view_name`, `view_display_id`, `view_dom_id`, `_wrapper_format`, ajax params, …) are stripped
  from the query first.
- The active display's link gets classes
  `views-display-switch__link views-display-switch__link--<display_id> views-display-switch__link--active`.

## Block switching mechanism (`hook_views_pre_view`)

`views_display_switch_views_pre_view()` checks whether the view's header/footer contains the
`display_switch` plugin, and if so reads `\Drupal::request()->get('mode')`. When `mode` differs
from the display being rendered it calls `$view->setDisplay($mode)` — this is what makes the
`?mode=` links switch block displays in place on the same page. (Because it reads a raw request
param and re-points the display, keep to the documented "one view per page" constraint to avoid
one view's `mode` affecting another.)

## Options schema

Stored in the view config under the area handler:

```
display_options.header.display_switch.displays:
  <display_id>:
    enabled: 0|1
    label: '<link text>'
```

There is no config schema shipped for these options (the module provides none).

## Validation warnings

`validateDisplay()` compares `filters`, `sorts`, `pager` and `arguments` between the current
display and each linked display. Any difference raises a **warning** message
("…uses different settings than…") but still saves — the module intentionally does not enforce
equality. To guarantee the visitor sees the same result set after switching, make the linked
displays share the same filter/sort/pager/contextual-filter configuration.

## Theming

- Theme hook: `views_display_switch` with a `links` render-array variable.
- Template: `templates/views-display-switch.html.twig` wraps the links in
  `<div class="views-display-switch">` and prints each `{{ link }}`. Override it in your theme to
  change the markup (e.g. render as buttons or a segmented control).
