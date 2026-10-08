# Services (view builders & extractors)

The Twig functions/filters delegate to these public services (`twig_tweak.services.yml`). You can
call them from PHP, but usually you just use the Twig helpers. Each builder handles access checks
and cache-metadata bubbling.

| Service | Class | Backs |
|---|---|---|
| `twig_tweak.twig_extension` | `TwigTweakExtension` | the whole Twig extension (tagged `twig.extension`) |
| `twig_tweak.block_view_builder` | `View\BlockViewBuilder` | `drupal_block()` |
| `twig_tweak.region_view_builder` | `View\RegionViewBuilder` | `drupal_region()` |
| `twig_tweak.entity_view_builder` | `View\EntityViewBuilder` | `drupal_entity()`, `view` filter |
| `twig_tweak.entity_form_view_builder` | `View\EntityFormViewBuilder` | `drupal_entity_form()` |
| `twig_tweak.field_view_builder` | `View\FieldViewBuilder` | `drupal_field()` |
| `twig_tweak.menu_view_builder` | `View\MenuViewBuilder` | `drupal_menu()` |
| `twig_tweak.image_view_builder` | `View\ImageViewBuilder` | `drupal_image()` |
| `twig_tweak.url_extractor` | `UrlExtractor` | `file_url` filter |
| `twig_tweak.uri_extractor` | `UriExtractor` | `file_uri` filter |
| `twig_tweak.cache_metadata_extractor` | `CacheMetadataExtractor` | `cache_metadata` filter |

Example:

```php
$build = \Drupal::service('twig_tweak.block_view_builder')
  ->build('system_branding_block', ['label' => 'Branding'], TRUE);
```

Most static helpers on `TwigTweakExtension` (e.g. `drupalEntity()`, `drupalToken()`, `drupalConfig()`)
are also callable directly if you need them outside Twig, but the services above are the stable
building blocks.
