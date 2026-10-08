<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The lottiefiles_player_formatter theme & JS player

Source: `lottiefiles_field.module` (`hook_theme`), `templates/lottiefiles-player-formatter.html.twig`,
`lottiefiles_field.libraries.yml`, `js/dist/lottie-player-0.3.0.js`.

## Theme hook

`hook_theme()` defines `lottiefiles_player_formatter` with variables: `uri`, `autoplay`, `background`,
`controls`, `hover`, `loop`, `mode`, `speed`, `selector`, `width`, `cssselector` (all default `NULL`).
The formatter (see [../configure/field.md](../configure/field.md)) supplies them.

## Template

`lottiefiles-player-formatter.html.twig` attaches the `lottiefiles_field/lottiefiles` library and
renders a `<lottie-player>` custom element:

```twig
{{ attach_library('lottiefiles_field/lottiefiles') }}
<lottie-player {% if width > 0 %}style=width:{{ width }}px{% endif %}
  class="lottiefiles-field-item {{ cssselector }}" id="{{ selector }}" src="{{ uri }}"
  {{ autoplay }} {{ background|raw }} {{ controls }} {{ hover }} {{ loop }}
  {{ mode|raw }} {{ speed|raw }}></lottie-player>
```

Booleans become bare HTML attributes (`autoplay`, `controls`, `hover`, `loop`) when set to 1;
`background`/`mode`/`speed` are emitted as `attr="value"` strings via `|raw`. `background` is already
`Xss::filter`ed by the formatter and constrained to `transparent`/hex by widget validation; `mode` and
`speed` come from fixed selects.

## Libraries

`lottiefiles_field.libraries.yml`:
- `lottiefiles` — loads `js/dist/lottie-player-0.3.0.js` in the page **header** (`header: true`,
  `minified: true`). This is the bundled LottieFiles `<lottie-player>` web component (v0.3.0).
- `lottiefiles_field.widget` → `js/widget.js` (node-form colour-picker wiring).
- `lottiefiles_field.mediawidget` → `js/media-widget.js` (media-library add form wiring).

## Notes for agents

- The animation JSON is fetched **client-side** by the player from `src` (the stored URI). An
  internal path is made absolute by the formatter; an external URL is passed through as-is, so the
  visitor's browser loads it directly.
- To restyle, target `.lottiefiles-field-item` or the per-field `{{ cssselector }}` class, or override
  the Twig template in your theme.
