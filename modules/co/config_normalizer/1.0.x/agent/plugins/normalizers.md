<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ConfigNormalizer` plugins

## The plugin type

| Piece | Value |
|---|---|
| Discovery dir | `src/Plugin/ConfigNormalizer/` |
| Manager service | `plugin.manager.config_normalizer` (`ConfigNormalizerManager`) |
| Annotation | `@ConfigNormalizer` (id, label, weight, description) |
| Interface | `ConfigNormalizerInterface` (`normalize($name, array &$data, array $context)`) |
| Base class | `ConfigNormalizerBase` (injects `entity_type.manager`) |
| Alter hook | `hook_config_normalizer_normalizer_info_alter()` |

Plugins run in ascending `weight` order (`ConfigItemNormalizer::normalize()`), each mutating
`$data` by reference.

## Shipped plugins

| id | weight | What it does |
|---|---|---|
| `active` | 0 | If the context's `reference_storage_service` is the **active** storage, copies `uuid` and `_core` from active onto the data (and drops an empty `uuid`), so those core-set values don't count as differences. |
| `sort` | 20 | Only in the default/`compare` mode: recursively sorts arrays — associative by key (`ksort`), indexed by value (`sort`). |
| `filter_format` | 20 | Only in the default/`compare` mode: for `filter.format.*` items, unsets the `roles` element (valid only on exported config). |

The `active` plugin decides "is this the active storage?" via `isActiveStorageContext()` (a
reverse container lookup checking the service id `config.storage`). `sort` and `filter_format`
gate on `isDefaultModeContext()` (mode === `compare`).

## Add your own normalizer

```php
namespace Drupal\my_module\Plugin\ConfigNormalizer;

use Drupal\config_normalizer\Plugin\ConfigNormalizerBase;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;

/**
 * @ConfigNormalizer(
 *   id = "my_norm",
 *   label = @Translation("My normalizer"),
 *   weight = 30,
 *   description = @Translation("Reconciles my volatile property."),
 * )
 */
class MyNormalizer extends ConfigNormalizerBase implements ContainerFactoryPluginInterface {

  public function normalize($name, array &$data, array $context) {
    // Inspect $context['normalization_mode'] ('compare' | 'provide') and
    // $context['reference_storage_service']; mutate $data in place.
    if (!empty($context['normalization_mode']) && $context['normalization_mode'] === 'compare') {
      unset($data['my_volatile_key']);
    }
  }

}
```

Weight it relative to `active`/`sort`/`filter_format` if order matters. Clear caches to register.
