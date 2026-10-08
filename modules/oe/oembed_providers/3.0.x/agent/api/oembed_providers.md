# Programmatic API

## The ProviderRepository (subclass of core's)

`OembedProvidersServiceProvider::alter()` rewrites core's `media.oembed.provider_repository`
service **in place**: it sets the class to `Drupal\oembed_providers\OEmbed\ProviderRepository`
(which **extends** core's `ProviderRepository`) and prepends `entity_type.manager` +
`module_handler` to the constructor arguments. There is **no** separate decorator service — you
still resolve the same core service id and get the subclass back.

```php
$repo = \Drupal::service('media.oembed.provider_repository');
$all  = $repo->getAll();          // [provider_name => \Drupal\media\OEmbed\Provider], custom + remote merged, sorted
$one  = $repo->get('Vimeo');      // inherited from core; single Provider; throws \InvalidArgumentException if unknown
$custom = $repo->getCustomProviders(); // the module's own custom providers, in providers.json shape
```

`getAll()` (overridden) behavior: returns non-expired KeyValue-cached data if present; otherwise
merges `getCustomProviders()` with the remote list (when `external_fetch` is on — remote entries
take precedence and cannot be overridden by custom ones), sorts by `provider_name`
(`strcasecmp`), fires `hook_oembed_providers_alter()`, builds `Provider` objects (skipping/logging
invalid ones), and re-caches in `keyvalue('media')->get('oembed_providers')` for `max_age`
(default 604800s / 1 week). Falls back to stale KeyValue data if the remote fetch fails or returns
an empty/invalid list; throws `ProviderException` only when there is no stored data to fall back
on. When `external_fetch` is off, only custom providers are used.

`getCustomProviders()` maps each `oembed_provider` config entity into a providers.json-style array
(`provider_name` from `label`, `provider_url`, and `endpoints` with `schemes`, `url`, `formats`
as filtered keys, plus `discovery` when set). It is keyed by the entity machine name.

## Creating providers/buckets in code

Both are config entities — use the entity API:

```php
use Drupal\oembed_providers\Entity\OembedProvider;
use Drupal\oembed_providers\Entity\ProviderBucket;

OembedProvider::create([
  'id' => 'example_provider',
  'label' => 'Example Provider',           // must match the endpoint's provider_name
  'provider_url' => 'https://example.com',
  'endpoints' => [[
    'schemes' => ['https://example.com/media/*'],
    'url' => 'https://example.com/oembed/{format}',
    'discovery' => TRUE,
    'formats' => ['json' => TRUE, 'xml' => FALSE],
  ]],
])->save();

ProviderBucket::create([
  'id' => 'remote_image',                   // media source becomes oembed:remote_image; keep id <= 14 chars
  'label' => 'Remote image',
  'providers' => ['Example Provider'],      // allowed provider NAMES
])->save();
```

Saving/deleting a provider (`OembedProvider::postSave()`/`postDelete()`) deletes the cached
`keyvalue('media')->get('oembed_providers')` store; saving a bucket (`ProviderBucket::postSave()`)
clears media source definitions. `ProviderBucket::calculateDependencies()` adds config
dependencies on the custom providers it references (matched by provider name).

## Hook — alter the merged provider list

```php
/**
 * Implements hook_oembed_providers_alter().
 * Fires in ProviderRepository::getAll() before Provider objects are built from the (pre-cache) array.
 */
function mymodule_oembed_providers_alter(array &$providers) {
  $providers[] = [
    'provider_name' => 'Custom Provider',
    'provider_url' => 'http://custom-provider.example.com',
    'endpoints' => [[
      'schemes' => ['https://custom-provider.example.com/id/*'],
      'url' => 'https://custom-provider.example.com/api/v2/oembed/',
      'discovery' => 'true',
    ]],
  ];
}
```

See `oembed_providers.api.php`. Buckets are exposed as `oembed:{id}` media sources via
`hook_media_source_info_alter()`, now implemented in the `MediaSourceHooks` OO hook class
(`#[Hook('media_source_info_alter')]`); `oembed_providers.module` keeps a `#[LegacyHook]` shim.
