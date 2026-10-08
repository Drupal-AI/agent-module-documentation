<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ProviderEnhancer` plugin type

Enhancers customise how a specific oEmbed **provider**'s embeds are lazy-loaded (extra
libraries, placeholder tweaks, iframe URL / markup changes).

- **Manager service:** `oembed_lazyload` (`ProviderEnhancerManager`).
- **Directory:** `src/Plugin/oembed_lazyload/ProviderEnhancer/`.
- **Discovery:** annotation `@ProviderEnhancer` (`Drupal\oembed_lazyload\Annotation\ProviderEnhancer`).
- **Interface / base:** `ProviderEnhancerInterface`, extend `ProviderEnhancerBase`.
- **Alter hook:** `hook_oembed_lazyload_alter` (`alterInfo('oembed_lazyload')`).
- **Selection:** the formatter calls `ProviderEnhancerManagerInterface::getEnhancerForProvider($providerName)`;
  the `fallback` enhancer (id `fallback`, empty `providers`) handles anything unmatched.

## Definition properties

| Property | Meaning |
|---|---|
| `id` | plugin id |
| `label` | human label |
| `providers` | array of oEmbed provider names this enhancer handles (e.g. `{ "YouTube" }`); empty = fallback |

## Interface methods (override on the base)

| Method | Purpose |
|---|---|
| `getLibraries()` | asset libraries to attach when this provider is present |
| `getPlaceholder($url, Resource $resource, array $settings)` | build/adjust the placeholder render array (e.g. add `#third_party_settings`) |
| `getIframe(Url $url, Resource $resource, array $settings)` | build the on-demand iframe render array |
| `alterOembedResponse($markup, array $options = [])` | rewrite the provider's oEmbed markup (e.g. append query params) |

## Implement one

```php
namespace Drupal\my_module\Plugin\oembed_lazyload\ProviderEnhancer;

use Drupal\oembed_lazyload\ProviderEnhancerBase;

/**
 * @ProviderEnhancer(
 *   id = "vimeo",
 *   label = "Vimeo",
 *   providers = { "Vimeo" }
 * )
 */
class VimeoEnhancer extends ProviderEnhancerBase {
  public function getLibraries() {
    $libs = parent::getLibraries();
    $libs[] = 'my_module/vimeo';
    return $libs;
  }
  // Optionally override getPlaceholder()/getIframe()/alterOembedResponse().
}
```

The shipped `oembed_lazyload_youtube` submodule's `youtube` enhancer is a full example (parses
the video id, adds a library, and rewrites the embed URL with YouTube player params).
