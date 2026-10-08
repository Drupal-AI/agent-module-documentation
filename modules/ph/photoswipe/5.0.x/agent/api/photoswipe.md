# Programmatic API — Twig function, service & options hook

## Attach a gallery in a Twig template — `attach_photoswipe()`

Provided by `PhotoswipeTwigExtension` (`src/TwigExtension/`), registered as the twig
function `attach_photoswipe`. Call it in a template to load the library and its init JS,
then mark up your own gallery.

```twig
<div class="myContext">
  {{ attach_photoswipe() }}
  <div class="photoswipe-gallery">
    <a href="/path/to/large.jpg" class="photoswipe">
      <img src="/path/to/large.jpg" alt="Beautiful picture" />
    </a>
  </div>
</div>
```

- The wrapper needs the `photoswipe-gallery` class; each trigger `<a>` needs the
  `photoswipe` class.
- Override options per call by passing an array:
  `{{ attach_photoswipe({'bgOpacity': 0.2}) }}`.

## Alter the options passed to PhotoSwipe — `hook_photoswipe_js_options_alter()`

Defined in `photoswipe.api.php`. Invoked by the assets manager (via both
`module_handler->alter()` and `theme.manager->alter()`) just before the options are written
to `drupalSettings.photoswipe.options`. Use it to change any PhotoSwipe option globally,
e.g. share buttons:

```php
/**
 * Implements hook_photoswipe_js_options_alter().
 */
function mymodule_photoswipe_js_options_alter(array &$settings) {
  $settings['shareEl'] = FALSE;
  // $settings['captionOptions'] = [...]; // used by the dynamic caption submodule
}
```

## The assets manager service — `photoswipe.assets_manager`

`Drupal\photoswipe\PhotoswipeAssetsManager` (interface
`PhotoswipeAssetsManagerInterface`). Its `attach(array &$element, array $optionsOverride = [])`
method attaches the `photoswipe/photoswipe.init` library and merges config `options` with any
override into `#attached['drupalSettings']['photoswipe']['options']`, firing
`hook_photoswipe_js_options_alter()`. The field formatters call this per rendered item;
the Twig function calls it too. `photoswipeMinPluginVersion` is `5.4.2`.

```php
/** @var \Drupal\photoswipe\PhotoswipeAssetsManagerInterface $am */
$am = \Drupal::service('photoswipe.assets_manager');
$am->attach($element, ['bgOpacity' => 0.5]);
```

Theme hooks `photoswipe_image_formatter` and `photoswipe_responsive_image_formatter`
(preprocess in `photoswipe.theme.inc`) render the individual gallery items and are the
hooks the caption submodule preprocesses.
