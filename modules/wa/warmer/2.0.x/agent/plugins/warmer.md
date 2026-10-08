<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `warmer` plugin type

Warmer defines one plugin type. Every cache warmer is a plugin of this type.

| Aspect | Value |
|---|---|
| Annotation | `@Warmer` (`Drupal\warmer\Annotation\Warmer`) — keys: `id`, `label`, `description` |
| Manager service | `plugin.manager.warmer` → `Drupal\warmer\Plugin\WarmerPluginManager` |
| Discovery directory | `src/Plugin/warmer/` in any module |
| Interface | `Drupal\warmer\Plugin\WarmerInterface` |
| Base class | `Drupal\warmer\Plugin\WarmerPluginBase` (implement this, not the raw interface) |
| Cache tag on definitions | `warmer_plugins` |

The base class already implements `ConfigurableInterface`, `PluginFormInterface`,
`ContainerFactoryPluginInterface` and `DependentPluginInterface`, and gives you the
`frequency` / `batchSize` config keys, the settings-form rows for them, validation, and the
`isActive()` / `markAsEnqueued()` scheduling logic. Default config from the base:
`frequency = 300` (seconds), `batchSize = 50`.

## Methods you implement

```php
namespace Drupal\my_module\Plugin\warmer;

use Drupal\Core\Form\SubformStateInterface;
use Drupal\warmer\Plugin\WarmerPluginBase;

/**
 * @Warmer(
 *   id = "my_warmer",
 *   label = @Translation("My Warmer"),
 *   description = @Translation("Warms my expensive cache.")
 * )
 */
class MyWarmer extends WarmerPluginBase {

  // Return the next page of item IDs after $cursor (NULL on first call).
  // Return [] to signal there are no more batches.
  public function buildIdsBatch($cursor) { /* ... */ }

  // Load the items for a batch of IDs.
  public function loadMultiple(array $ids = []) { /* ... */ }

  // Do the actual warming; return the count successfully warmed.
  public function warmMultiple(array $items = []) { /* ... */ }

  // OPTIONAL: add plugin-specific settings-form fields (merged with
  // the frequency/batchSize rows the base class already renders).
  public function addMoreConfigurationFormElements(array $form, SubformStateInterface $form_state) {
    // return $form;
  }
}
```

Enqueue flow (see `WarmerCommands::enqueue` and `hook_cron`): the manager instantiates the
warmer, `buildIdsBatch()` is called repeatedly (each result's last ID becomes the next
cursor) and every returned batch is pushed to the `warmer` queue via `QueueManager`. The
queue worker later calls `loadMultiple()` then `warmMultiple()` per batch.

## Config-schema requirement

If your warmer stores extra settings, declare a schema
`warmer.settings.warmer_plugin.<id>` (a mapping that includes `id`, `frequency`,
`batchSize` plus your keys). See `warmer_entity` / `warmer_cdn` schema for examples.

## Warmers registered on this site

Provided by the submodules: `entity` (warmer_entity), `cdn` and `sitemap` (warmer_cdn).
List them live with `drush warmer:list`.
