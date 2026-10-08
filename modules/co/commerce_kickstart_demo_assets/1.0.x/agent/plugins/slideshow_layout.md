# Slideshow layout (`cklb_slideshow`)

A Layout Builder layout plugin the module *provides* (it does **not** define a new plugin type). The
Commerce Kickstart Demo recipe uses it to build a hero/slideshow section: each block placed in the
layout's region becomes one carousel slide.

## Plugin
- **Class:** `Drupal\commerce_kickstart_demo_assets\Plugin\Layout\SlideshowLayout`
- **Extends:** `Drupal\bootstrap_layout_builder\Plugin\Layout\BootstrapLayout` — so
  `bootstrap_layout_builder` MUST be installed or the plugin class cannot load. The class body is
  empty; it only re-labels/re-templates the Bootstrap layout and attaches the slideshow library.
- **`@Layout` annotation:**
  - `id = "cklb_slideshow"`, `label = "Slideshow"`
  - `template = "templates/cklb_slideshow"`
  - `library = "commerce_kickstart_demo_assets/cklb-slideshow"`
  - `description` = "Each block added to this region will be an individual slide."
  - regions: single region `main` (label "Main content"); `icon_map` `{0 = {"main"}}`

## Template
`templates/cklb_slideshow.html.twig` renders `content.main` inside `<div class="slideshow">`, with the
region wrapper carrying classes `main-region cklb-slideshow`. The `cklb-slideshow` class is the JS
hook. Nothing renders when `content` is empty.

## Libraries (`commerce_kickstart_demo_assets.libraries.yml`)
| Library | Contents | Depends on |
|---|---|---|
| `cklb-slideshow` | `js/cklb-slideshow.js` | `core/jquery`, `core/once`, `commerce_kickstart_demo_assets/slick` |
| `slick` | slick-carousel JS + CSS (component + theme) | — |

The `slick` library loads slick-carousel from `//cdnjs.cloudflare.com` (external, protocol-relative):
`slick.js` + `slick.css` at 1.8.1 and `slick-theme.min.css` at 1.9.0.

## Runtime behavior (`js/cklb-slideshow.js`)
`Drupal.behaviors.slickSlider` runs via `once('slick-slider', '.cklb-slideshow:not(.layout-builder__region)')`
— i.e. on the rendered front-end region, but not inside the Layout Builder editor. It initializes
slick with `{ arrows: true, dots: true, infinite: true, speed: 500, fade: true }`. On `init` and
`beforeChange` it copies a `text-white` class from the active slide's `.block-layout-builder` up to
the slider, so light-on-dark hero text stays readable per slide. A small `jQuery.type` polyfill is
defined for older slick builds.

## Using it
Place any block(s) into the layout's **Main content** region in Layout Builder; each block renders as
one slide. There are no configuration keys beyond what the parent `BootstrapLayout` already exposes.
