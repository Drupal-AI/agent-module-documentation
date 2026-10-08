# View Marquee — the Views style plugin

Class `Drupal\view_marquee\Plugin\views\style\ViewMarquee` extends `StylePluginBase`
(`usesRowPlugin = TRUE`). Selected on a view display via **Format → "View Marquee"**. There
is no global config; all settings are the style options below.

## Options (buildOptionsForm / defineOptions)

| Option | Type | Default | Effect |
|---|---|---|---|
| `row_class` | textfield | `marquee-row` | CSS class placed on each row's wrapper `<div>`. |
| `direction` | select | `left` | `left`, `up`, `right`, `down` → `<marquee direction=…>`. |
| `behavior` | select | `scroll` | `scroll` or `alternate` → `<marquee behavior=…>`. |
| `speed` | textfield | (empty) | Pixels per step → `scrollamount=…` (defaults to `1` if empty). |
| `delay` | textfield | (empty) | Delay between steps → `scrolldelay=…` (defaults to `1` if empty). |
| `mouseover` | checkbox | `TRUE` | When on, emits inline `onmouseover=this.stop(); onmouseout=this.start();` to pause on hover. |

Only `direction`, `behavior`, and `mouseover` are declared in `defineOptions()`; `row_class`,
`speed`, and `delay` are read straight from `$this->options` in the form/preprocess.

## Rendering pipeline

1. `template_preprocess_views_view_view_marquee()` (`view-marquee.theme.inc`) converts options
   into attribute strings: `direction=<v>`, `behavior=<v>`, `scrollamount=<speed|1>`,
   `scrolldelay=<delay|1>`, `class=<row_class|marquee-row>`, and the mouseover handlers.
2. `templates/views-view-view-marquee.html.twig` attaches library `view_marquee/marquee-style`,
   adds a `views-view-marquee` / `marquee-direction-<direction>` wrapper `<div>`, then emits
   `<marquee {{ direction }} {{ behavior }} {{ speed }} {{ delay }} {{ mouseover }}>` with each
   row wrapped in `<div {{ row_class }}>`.

## Notes

- The option values are emitted into the `<marquee>` tag as pre-built attribute strings
  (`direction=<value>` etc.) rather than through Twig attribute escaping. These values are
  authored only by users who can *administer views*; the row content itself is normal Views
  field output.
- No JavaScript ships with the plugin — scrolling is the browser's native `<marquee>` behavior
  plus inline start/stop handlers.
- `<marquee>` is deprecated in the HTML spec; use with the understanding that future browsers
  may drop it.
