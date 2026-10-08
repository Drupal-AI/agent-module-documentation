<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Views Slick Animation carousel

There is **no** admin settings page and no config schema shipped. All configuration is the
Views **style plugin** `slickanimate` (label "Views slick Animation"), stored inside the
View's own config under `style.options.views_slick_settings`.

## Steps
1. Create/edit a View, add a **Fields**-based display (uses row plugin + row class).
2. Set **Format → "Views slick Animation"** and open its settings.
3. Configure the groups below. Add fields you want to reference (image, title, etc.) as View fields first, then map them in the Animation Model group.

## Options (`views_slick_settings` keys and defaults)
Top level:
- `styles` (radios) `basic` | `without_styles` — default `basic`. `basic` loads bundled Slick + basic CSS; anything else loads Slick from a CDN (`slick_slide_cdn` library, cdnjs 1.9.0).
- `autoWidth` (checkbox), `autoplay` (checkbox), `autoplaySpeed` (number, default `3000`, ms; disabled unless autoplay checked).
- `arrows` (checkbox, default on), `centerMode` (checkbox), `centerPadding` (text, default `50px`).
- `dots` (checkbox), `infinite` (checkbox, default on), `initialSlide` (number, default `0`).
- `lazyLoad` (radios) `ondemand` | `progressive` — default `ondemand`.
- `mobileFirst` (checkbox), `slidesToShow` (number, default `1`), `slidesToScroll` (number, default `1`), `speed` (number, default `300`), `variableWidth` (checkbox).

`responsive` (details) → `mobile` / `tablet` / `desktop`, each with:
- `breakpoint` (text; defaults `576` / `992` / `1200`), `slidesToShow`, `slidesToScroll`, `centerMode`, `centerPadding`.

`additional` (details) — Slick passthrough options, each with sensible Slick defaults:
`accessibility` (on), `adaptiveHeight`, `draggable` (on), `cssEase` (`ease-in-out`), `fade`,
`focusOnSelect`, `easing` (`linear`), `edgeFriction` (`0.15`), `pauseOnFocus` (on),
`pauseOnHover` (on), `pauseOnDotsHover` (on), `respondTo` (`window`|`slider`|`min`),
`rows` (`1`), `slidesPerRow` (`1`), `swipe` (on), `swipeToSlide`, `touchMove` (on),
`touchThreshold` (`5`), `useCSS` (on), `useTransform` (on), `vertical`, `verticalSwiping`,
`rtl`, `waitForAnimate` (on), `zIndex` (`1000`).

`animationModel` (details) — the animation/layout group:
- `checkForAnimate` (checkbox) — master switch; when off, slides render without animation.
- `modelView` (select) `default` | `hero_banner` | `card` — chooses the slide layout. Field
  mappings below are **disabled/ignored** while `modelView` is `default`.
- Field-mapping selects (options = the View's field labels, or "None"):
  `slickSlideImage`, `slickSlideTitle`, `slickSlideSubtitle`, `slickSlideDescription`,
  `slickSlideButton`. For `hero_banner`/`card`, image + title are marked required.
- Per-element animation type selects (animate.css classes, e.g. `animate__fadeInLeft`,
  `animate__slideInUp`, `animate__zoomIn`, `animate__lightSpeedInRight`):
  `imageAnimationType` (image uses `zoomInImage`/`zoomOutImage`/`animate__slideInLeft|Right`,
  default `zoomInImage`), `titleAnimationType`, `subTitleAnimationType`,
  `descriptionAnimationType` (each default `animate__fadeInLeft`). These are **disabled when
  `rendomAnimate` is checked**.
- `rendomAnimate` (checkbox) — auto/random mode; cycles through `multipleAnimates`.
- `multipleAnimates` (multi-select) — set of `animate__slideIn*` classes to rotate through;
  only enabled when `rendomAnimate` is checked.

## Runtime
`views_slick_settings` is emitted to `drupalSettings.views_slick_animate.slick_setting[<id>]`
and consumed by `js/slick-slider-animation.js` (Drupal behavior `views_slick_animate`), which
initializes Slick per carousel `id`. No Drupal-side re-read is needed.
