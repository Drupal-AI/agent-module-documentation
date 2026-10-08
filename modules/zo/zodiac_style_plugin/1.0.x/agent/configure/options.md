<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Zodiac slider style

There is no settings page. The style is configured per view: in the Views UI, set **Format →
Show/Style** to **Zodiac**, use the **fields** row style, then open the style settings. All options
live in the view's own config under the style plugin; schema key `views.style.zodiac_style_plugin`.

## Base options

Set globally (and used as the fallback when breakpoint overrides are absent). Defaults come from
`Zodiac::defineOptions()`.

| Option (config key) | Form widget | Type | Default | Notes |
|---|---|---|---|---|
| `autoplay` | checkbox | bool | `TRUE` | Auto-cycle slides. |
| `autoplaySpeed` | number | int (ms) | `5000` | Required. `min 1000`, `step 100`. Delay between auto-cycles. |
| `enableLiveRegion` | checkbox | bool | `TRUE` | Render an ARIA live region announcing slide position/title. Base-only. |
| `gap` | number | int (px) | `8` | Required. `min 0`. Space between slides. |
| `infiniteScrolling` | checkbox | bool | `TRUE` | Loop endlessly. Base-only. |
| `itemsPerView` | number | int | `5` | Required. `min 1`. Slides visible at once ("number of columns"). |
| `liveRegionText` | textfield | string | `Slide @position of @total @title` | Template for live-region text. Base-only. Placeholders `@position`, `@total`, `@title` are filled client-side by the JS (`@title` from an item's `data-zodiac-live-region-title` attribute). |
| `pauseOnHover` | checkbox | bool | `TRUE` | Pause autoplay while hovered. |
| `transitionSpeed` | number | int (ms) | `500` | Required. `min 100`, `step 100`. Slide animation duration. |

## Per-breakpoint overrides

The **Use Breakpoint Group** select (`breakpoint_group`) lists every core breakpoint group
(`\Drupal\breakpoint\BreakpointManagerInterface::getGroups()`). Pick one and a collapsible
**details** element appears for each breakpoint in that group, letting you override a subset of the
options for that breakpoint. Stored under `breakpoint_options`, keyed by the breakpoint id with the
group prefix stripped (config keys cannot contain `.`).

Overridable per breakpoint (each defaults to "- Use default -", i.e. unset → falls back to base):
`autoplay`, `autoplaySpeed`, `gap`, `itemsPerView`, `pauseOnHover`, `transitionSpeed`.
NOT overridable (base-only): `infiniteScrolling`, `enableLiveRegion`, `liveRegionText`.

At render time (`Zodiac::getZodiacSettings()`) each configured breakpoint's **media query string**
(from the breakpoint definition) becomes a key under `mediaQueryOptions` in the settings handed to
the JS, e.g. `mediaQueryOptions["(min-width: 992px)"] = { itemsPerView: 3, ... }`. Breakpoints with
an empty media query are skipped. If a breakpoint group is selected but no overrides are set,
`submitOptionsForm()` clears the group back to empty.

## Config shape (as stored in the view YAML)

```yaml
display:
  default:
    display_options:
      style:
        type: zodiac_style_plugin
        options:
          base_options:
            autoplay: true
            autoplaySpeed: 5000
            enableLiveRegion: true
            gap: 8
            infiniteScrolling: true
            itemsPerView: 5
            liveRegionText: 'Slide @position of @total @title'
            pauseOnHover: true
            transitionSpeed: 500
          breakpoint_group: ''      # e.g. 'olivero' to enable overrides
          breakpoint_options: {}    # keyed by breakpoint id sans group prefix
      row:
        type: fields
```

Values are cast on submit by `Zodiac::getTypedOptions()` (`boolval`/`intval`/`strval`) and empty
strings are dropped, so stored config is always correctly typed. Schema types:
`zodiac_style_plugin_base_options` (base) and `zodiac_style_plugin_breakpoint_options` (per-breakpoint,
all keys `nullable`), defined in `config/schema/zodiac_style_plugin.views.schema.yml`.
