# The Font Awesome libraries

The whole module is `lp_fontawesome.libraries.yml`. It defines two libraries.

## `lp_fontawesome/fontawesome` (CSS / webfont — the default)

Loads `all.min.css` for Font Awesome **6.7.2** from jsDelivr:
`https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/css/all.min.css` (external, minified).
Extra `libraries_provider` metadata: `enabled: true`, `source: cdn.jsdelivr.net`,
`npm_name: '@fortawesome/fontawesome-free'`.

## `lp_fontawesome/fontawesome-svg` (SVG + JS)

Loads `all.min.js` (SVG-with-JS mode) from the same CDN. `libraries_provider.enabled: false` by
default, and it declares `replaces: [lp_fontawesome__fontawesome]` — i.e. it stands in for the CSS
library when you use the JS/SVG approach instead.

## Attaching it

```twig
{# In a Twig template #}
{{ attach_library('lp_fontawesome/fontawesome') }}
<i class="fa-solid fa-star"></i>
```

```php
// In a render array / preprocess
$build['#attached']['library'][] = 'lp_fontawesome/fontawesome';
```

```yaml
# In your theme's or module's THEME.libraries.yml, as a dependency
my_theme_global:
  dependencies:
    - lp_fontawesome/fontawesome
```

Use the SVG build by attaching `lp_fontawesome/fontawesome-svg` instead.

## Version mapping

The module version tracks Font Awesome with the **minor multiplied by 10**: module `6.7.20` →
Font Awesome `6.7.2`. This lets the module release its own minor bumps without changing the
upstream FA version.

## Changing version / serving locally (optional)

The library works out of the box from the CDN. To pin a different version or serve the files from
the local filesystem, install the optional `drupal/libraries_provider` module; it reads the
`libraries_provider` keys on these library definitions (`source`, `npm_name`, `enabled`). It is
**not** a dependency — install it only if you need those overrides.

## Inspecting the live definition

```php
\Drupal::service('library.discovery')->getLibraryByName('lp_fontawesome', 'fontawesome');
// returns the resolved definition (css/js assets, version, remote, license, libraries_provider)
```
