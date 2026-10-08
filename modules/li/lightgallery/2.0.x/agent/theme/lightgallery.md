# Theme hook & libraries — build a custom gallery

Beyond the field formatters, the module exposes a reusable `lightgallery` theme hook so any code can
render and auto-initialise a lightGallery from a render array.

## Theme hook

Declared in `lightgallery_theme()`; template `templates/lightgallery.html.twig`; preprocess
`template_preprocess_lightgallery()`.

| Variable | Default | Meaning |
|---|---|---|
| `items` | `[]` | Array of items, each `['attributes' => [...], 'content' => <render array>, 'item' => <field item, optional>]`. `attributes` becomes the item wrapper (e.g. `data-src`, `data-sub-html`, `data-poster`, `data-video`); wrapped in `Attribute` objects by the preprocess. |
| `inline` | `FALSE` | Render inline; adds `lightgallery--inline` class and a `.lightgallery__inline-container`. |
| `settings` | `[]` | Associative array of lightGallery settings passed straight to the JS init (see lightgalleryjs.com/docs/settings). `galleryId` seeds the element id. |
| `init` | `TRUE` | When true, adds `lightgallery-init` class + attaches `lightgallery/init` so the JS behavior auto-initialises it. Set `FALSE` to initialise yourself. |

Example:

```php
$build = [
  '#theme' => 'lightgallery',
  '#items' => [
    ['attributes' => ['data-src' => '/full/a.jpg'], 'content' => ['#theme' => 'image', '#uri' => '/thumb/a.jpg']],
  ],
  '#inline' => FALSE,
  '#settings' => ['plugins' => ['lgThumbnail'], 'speed' => 500],
  '#init' => TRUE,
];
```

## What the preprocess does

`template_preprocess_lightgallery()`:
- injects `settings['licenseKey']` from `lightgallery.settings:license_key` and adds cache tag
  `config:lightgallery.settings`;
- assigns a unique element `id` (`settings['galleryId']` or `Html::getUniqueId('lightgallery')`) and
  publishes `drupalSettings.lightgallery[id] = {inline, settings}`;
- attaches the base library `lightgallery/lightgallery`;
- for each name in `settings['plugins']`, attaches the matching plugin library (see map below);
- attaches `lightgallery/thumbnail` for the `*_thumbnail` theme suggestions and `lightgallery/init` when
  `init` is true.

## Asset libraries (`lightgallery.libraries.yml`)

Base + init load lightGallery from `/libraries/lightgallery/dist/…` (must be installed there):

- `lightgallery/lightgallery` — core JS/CSS.
- `lightgallery/init` — the module's `js/init.js` (depends on core/once, core/drupal, the base library).
- `lightgallery/thumbnail` — the module's `css/thumbnail.css`.
- Plugin libraries `lightgallery/lightgallery-<name>` for `<name>` ∈ `autoplay, comment, fullscreen,
  hash, medium-zoom, pager, relative-caption, rotate, share, thumbnail, video, vimeo-thumbnail, zoom`.

Plugin-name → library map used by the preprocess (`settings['plugins']` values):
`lgAutoplay→autoplay, lgComment→comment, lgFullscreen→fullscreen, lgHash→hash, lgMediumZoom→medium-zoom,
lgPager→pager, lgRelativeCaption→relative-caption, lgRotate→rotate, lgShare→share, lgThumbnail→thumbnail,
lgVideo→video, lgVimeoThumbnail→vimeo-thumbnail, lgZoom→zoom`.

## JS init

`js/init.js` defines `Drupal.behaviors.lightgalleryInit`: for each `.lightgallery-init[id]`, it resolves
plugin string names to the global `window[<name>]` objects, targets `.lightgallery__items` (with
`.lightgallery__inline-container` as `container` when inline), calls `lightGallery(element, settings)`,
auto-opens inline galleries after 200 ms, and stores each instance in the module-global
`lightgalleryInstances[id]` for other scripts to reuse.
