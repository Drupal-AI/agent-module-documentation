<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming / template variables

## Theme hook
`views_slick_animate_theme()` registers the theme `slickanimate` with preprocess
`template_preprocess_views_view_slickanimate` (in `views_slick_animate.theme.inc`) and template
`templates/slickanimate.html.twig`. Override by copying that template into your theme.

## Libraries (`views_slick_animate.libraries.yml`)
- `slickanimatesettings` — always attached by preprocess; `css/custom_style.css` +
  `js/slick-slider-animation.js` (init behavior). Deps: jquery, once, drupalSettings.
- `slicklib` — bundled Slick JS/CSS. `basiced` — basic slider CSS. Both attached in-template
  when `slick_styles == 'basic'`.
- `animated` — `js/slick-animation.min.js` + `css/animate.css`, attached when animation is on.
- `slick_slide_cdn` — loads Slick 1.9.0 from cdnjs; attached when `slick_styles != 'basic'`.

## Variables passed to the template
- `id` — unique DOM id (`Html::getUniqueId('slickanimate-<viewid>-<display>')`).
- `slick_styles` — `basic` | `without_styles`.
- `modelview` — `default` | `card` | `hero_banner`.
- `animate_make` — bool (`checkForAnimate`); false = static markup, true = animated markup.
- `autoanimate` — bool (`rendomAnimate`); emitted as `animate-auto-<0|1>` wrapper class.
- `rows` — for `card`/`hero_banner` each row is restructured to `slickSlideImage`,
  `slickSlideTitle/Subtitle/Description/Button` (and `content`/`animation` sub-arrays for hero),
  plus `attributes` and per-element `*animation` keys. For `default`, rows are the rendered View rows.

## Layout notes
- `default` — each row wrapped in `.slide_default`.
- `card` — `.card` rows with `.card-body`; elements wrapped in `.animated` with
  `data-animation-in="<animate.css class>"` when animating.
- `hero_banner` — image in `.image-media > .animated.img-zoomInImage`, text in
  `.slick_slide_content`; `position_content` is split on `__` to derive a positioning class.
- Field values come from `$view->style_plugin->getField()` (standard Views field rendering /
  sanitization); animation values come from fixed admin-selected option lists.
