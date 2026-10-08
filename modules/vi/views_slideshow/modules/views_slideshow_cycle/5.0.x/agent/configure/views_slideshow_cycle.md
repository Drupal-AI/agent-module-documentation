# Configure the Cycle engine

No standalone form. In a View using the **Slideshow** style, set **Slideshow Type** to
**Cycle**; a "Cycle options" fieldset then appears. Settings are stored in the display's
`style.options` under the `views_slideshow_cycle` key. The plugin is
`Drupal\views_slideshow_cycle\Plugin\ViewsSlideshowType\Cycle` (id `views_slideshow_cycle`).

## Key options (`defaultConfiguration()` defaults)

| Key | Default | Meaning |
|---|---|---|
| `effect` | `fade` | Transition effect (fade, scrollUp/Down/Left/Right, blindX/Y/Z, zoom, shuffle, curtainX/Y, …) |
| `timeout` | `5000` | ms between transitions; **0 = do not auto-rotate** |
| `speed` | `700` | ms each transition lasts (numeric) |
| `delay` | `0` | ms offset added to the first slide's timeout |
| `sync` | `1` | Transition out/in simultaneously |
| `random` | `0` | Randomize slide order |
| `pause` | `1` | Pause on hover |
| `pause_on_click` | `0` | Pause when a slide is clicked |
| `start_paused` | `0` | Start in the paused state |
| `remember_slide` / `remember_slide_days` | `0` / `1` | Resume returning visitors on last slide viewed |
| `pause_when_hidden` / `pause_when_hidden_type` / `amount_allowed_visible` | `0` / `full` / `''` | Pause when scrolled out of view; threshold method + amount |
| `nowrap` | `0` | End after last slide instead of wrapping |
| `fixed_height` | `1` | Slide window height fits the tallest slide |
| `items_per_slide` / `items_per_slide_first` / `items_per_slide_first_number` | `1` / `FALSE` / `1` | Items per slide (optional different first slide) |
| `wait_for_image_load` / `wait_for_image_load_timeout` | `1` / `3000` | Wait for images before starting, fallback ms |
| `cleartype` / `cleartypenobg` | `'true'` / `'false'` | IE ClearType tweaks |
| `advanced_options` | `'{}'` | Raw jQuery Cycle options JSON (needs json2.js) |

`validateConfigurationForm()` enforces that `timeout`, `speed`, and `remember_slide_days` are
numeric. The **jQuery Cycle Custom Options** section (`advanced_options`) exposes every native
Cycle option (after, before, fx, fxFn, easing, continuous, autostop, …) and only appears when
`json2.js` is installed. If jQuery Cycle itself is missing the form shows a red warning.

Actions the engine `accepts`: `goToSlide`, `nextSlide`, `pause`, `play`, `previousSlide`.
Events it `calls`: `transitionBegin`, `transitionEnd`, `goToSlide`, `pause`, `play`,
`nextSlide`, `previousSlide` — this is how base-module widgets (pager, controls, counter) drive
and follow the slideshow.
