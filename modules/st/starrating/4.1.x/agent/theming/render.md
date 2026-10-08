# Theming the rating output

## Theme hook `starrating_formatter`

Registered by `starrating_theme()`; template `templates/starrating-formatter.html.twig`.
Variables:

| Var | Meaning |
|---|---|
| `rate` | the score (int for the icon/`value` formatters; string `rate/max` for `starrating_value_rating`) |
| `min` | always `0` |
| `max` | the field's `max_value` |
| `icon_type` | icon set id (e.g. `star`, `heart`) |
| `icon_color` | color variant `1`–`8` |
| `fill_blank` | whether to render empty icons up to `max` |
| `type` | `starrating` (icon rendering) or `value` (just prints `rate`) |

Template logic (icon mode): loops `min..max`, emitting a `<div class="rate-image …">` per
position. "On" icons use class `<icon_type><icon_color>-on`; when `fill_blank` is set, positions
above the score use `<icon_type>-off`. Classes also carry `odd`/`even` and `s<N>` (position).
When `type != 'starrating'` it simply prints `{{ rate }}` (used by `starrating_value` and
`starrating_value_rating`).

## Icon CSS libraries

`starrating.libraries.yml` defines one CSS-only library **per icon type**
(`airplane`, `car`, `check`, `coffee`, `custom`, `dollar`, `drupalicon`, `fire`, `food`,
`heart`, `human`, `movie`, `music`, `smiley`, `star`, `starline`, `thumbsup`). The icon
formatter attaches `starrating/<icon_type>` in `viewElements()`, so the sprite/background for
the chosen icon set loads automatically. Each library maps to `css/<icon_type>.css`.

## Overriding

- **Custom icons:** choose `icon_type = custom` and override `css/custom.css` in your theme
  (or a library override) to point at your own icon images.
- **Custom markup:** override `starrating-formatter.html.twig` in your theme. The variables
  above are all you get; the numeric formatters just echo `rate`.
- To restyle an existing set, override the corresponding `starrating/<icon_type>` library's CSS.
