# Hooks (video_embed_field.api.php)

## Preprocess the iframe render element
The `video_embed_iframe` element exposes `url`, `query` (query-string params), `attributes`
(iframe HTML attributes) and `provider` (read-only).

```php
function hook_preprocess_video_embed_iframe(&$variables) {
  if ($variables['provider'] == 'vimeo') {
    $variables['attributes']['class'][] = 'vimeo-embed';
  }
}
```

Per-provider variant (only fires for that provider):
```php
function hook_preprocess_video_embed_iframe__youtube(&$variables) {
  $variables['query']['modestbranding'] = '1';   // tweak the YouTube embed URL
}
```

## Alter provider plugin definitions
```php
function hook_video_embed_field_provider_info_alter(&$definitions) {
  // Swap or remove a provider implementation.
  $definitions['youtube']['class'] = 'Drupal\my_module\CustomYouTubeProvider';
}
```
(`ProviderManager` calls `alterInfo('video_embed_field_provider_info')`.)
