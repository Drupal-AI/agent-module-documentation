<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnimateCSS procedural helpers

Public procedural functions in `animatecss.module`, mainly used to build animation settings forms (the `animatecss_ui` submodule consumes them). All return arrays.

| Function | Returns |
|---|---|
| `animatecss_animation_names($animation_name = '')` | The full catalog: nested array keyed by group (`attention`, `back`, `bouncing`, `fading`, `flippers`, `lightspeed`, `rotating`, `specials`, `zooming`, `sliding`), each split into `both`/`entrances`/`exits` → human-labeled name lists (e.g. `bounce`, `fadeInUp`, `zoomOut`). Merges in names added via `hook_animatecss_animation_names()`. |
| `animatecss_animation_options($mode = 'both', $grouping = TRUE, $names = [])` | Flattened `#options`-ready list of animation names. `$mode` = `both`\|`entrances`\|`exits`; `$grouping` keeps optgroup labels; `$names` limits to specific groups. |
| `animatecss_delay_options()` | Delay options: `''`(none), `delay-1s`…`delay-5s`, `custom`. |
| `animatecss_speed_options()` | Speed options: `slower`, `slow`, `medium`, `fast`, `faster`, `custom`. |
| `animatecss_repeat_options()` | Repeat options: `repeat-1`, `repeat-2`, `repeat-3`, `infinite`. |
| `animatecss_event_options()` | jQuery event triggers: `load`, `scroll`, `click`, `dblclick`, `touchstart/end`, `focus`, `blur`, `mouseover/out/down/up/enter/leave/move`, `keyup/down/press`, `submit`, `resize`. |
| `animatecss_scroll_options($options)` | Scroll-reveal libraries registered via `hook_animatecss_scroll_options()`; each entry validated to have a lowercase machine name plus non-empty `name` and `description`. |
| `animatecss_check_installed()` | Bool — whether the local `/libraries/animate.css/animate.min.css` exists. |

Example — build a select of entrance animations:

```php
$form['animation'] = [
  '#type' => 'select',
  '#title' => t('Animation'),
  '#options' => animatecss_animation_options('entrances'),
];
```
