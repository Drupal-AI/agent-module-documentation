<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animation styles and CSS libraries

The `theme` config value picks one of four CSS-only libraries defined in
`better_search.libraries.yml`. Each is attached to the search form by
`better_search_form_alter()`.

| `theme` | Settings-form label | Library attached | Effect |
|---|---|---|---|
| `0` | Background Fade | `better_search/background_fade` | Field background fades on focus |
| `1` | Expand on Hover | `better_search/expand_on_hover` | Field widens on hover |
| `2` | Expand Icon on Hover | `better_search/increase_icon_size` | Search icon grows on hover |
| `3` | Slide Icon on Hover | `better_search/on_hover_button` | Icon/button slides in (icon rendered as `#suffix`, not `#prefix`) |

Each library is a single stylesheet under `css/` (e.g. `css/background_fade.css`) attached in
the `theme` CSS group. The SVG search icons live in `css/images/` (`search-icon.svg`,
`search-icon1.svg`).

## The icon markup

The module inserts an icon element next to the input:

```html
<div class="icon"><i class="better_search"></i></div>
```

It is a `#prefix` for themes 0–2 and a `#suffix` for theme 3. Style/override `.icon` and
`i.better_search` in your theme to change the icon. `better_search_preprocess_form_element()`
also adds a `clearfix` class to `search`-type form elements.

## Overriding

There are no Twig templates to override — customise by:
- adding your own CSS targeting `.icon` / `i.better_search` / the search input, or
- setting `theme` to the closest style and layering CSS on top, or
- pointing `block_form_id`/`input_name` at a custom search form (see configure/settings.md).
