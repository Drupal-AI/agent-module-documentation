<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `media` Access Consumer

adva_media contributes exactly one plugin: an **Access Consumer** for the core Media entity type.
It does not define a new plugin *type* — it provides a plugin *instance* of adva's
`AccessConsumer` plugin type (manager `plugin.manager.adva.consumer`, annotation
`Drupal\adva\Annotation\AccessConsumer`, discovered under `Plugin/adva/AccessConsumer/`).

## The class

`Drupal\adva_media\Plugin\adva\AccessConsumer\MediaAccessConsumer`

```php
/**
 * @AccessConsumer(
 *  id = "media",
 *  entityType = "media",
 * )
 */
class MediaAccessConsumer extends OverridingAccessConsumer {
}
```

The body is empty — every behavior comes from `Drupal\adva\Plugin\adva\OverridingAccessConsumer`
(and its base `AccessConsumer`). The two annotation keys are the entire configuration:
`id = "media"` names the consumer, `entityType = "media"` binds it to the core Media entity type.

## What "overriding" means for media

Because it extends `OverridingAccessConsumer` (an `OverridingAccessConsumerInterface`), enabling
adva_media does two things beyond exposing provider config:

1. **Handler swap.** On `hook_entity_type_build` (`adva_entity_type_build()` in `adva.module`),
   adva iterates every overriding consumer and calls `overrideAccessControlHandler()` for its
   entity type. For `media` this:
   - stashes the current access handler class (core `Drupal\media\MediaAccessControlHandler`)
     under the handler id `adva_access_legacy` (`AdvancedAccessEntityAccessControlHandler::LEGACY_HANDLER_ID`), and
   - sets the entity type's access handler to `\Drupal\adva\AdvancedAccessEntityAccessControlHandler`.

   At runtime that handler consults the legacy core handler first and then adva's grant storage
   for the `view`/`update`/`delete` operations. See
   [../../../../../1.2.x/agent/api/access-model.md](../../../../../1.2.x/agent/api/access-model.md).

2. **Record storage & rebuild.** Media access records live in the shared `adva_access` table with
   `entity_type = 'media'`. `adva_entity_insert/update/delete` keep a media item's records in sync;
   a config change queues a full rebuild in `adva_rebuild_access_records:media`
   (`RebuildAccessRecordsQueueWorker`), also runnable as a batch via
   `adva.batch.consumer_access_rebuild`. `MediaAccessConsumer::onChange()` (inherited) calls
   `queue()` whenever the consumer's config entity is saved.

## Media types (bundles)

Media is a bundled entity type (bundle entity `media_type`). adva's built-in providers that extend
`Drupal\adva\Plugin\adva\EntityTypeAccessProvider` (including the `anonymous` provider) therefore
expose **default** and **per-media-type** configuration on the settings form, so grants can be set
for all media types or overridden for a specific type. Provider records are computed by each
provider's `getAccessRecords($entity)` / `getAccessGrants($operation, $account)`.

## Adding an overriding consumer for another entity type

adva_media is the reference example. To bring another entity type under adva's overriding handler,
drop a class in your module at `src/Plugin/adva/AccessConsumer/`:

```php
namespace Drupal\my_module\Plugin\adva\AccessConsumer;

use Drupal\adva\Plugin\adva\OverridingAccessConsumer;

/**
 * @AccessConsumer(
 *   id = "my_type",
 *   entityType = "my_entity_type",
 * )
 */
class MyTypeAccessConsumer extends OverridingAccessConsumer {}
```

The entity type must declare an `access` handler (the override preserves and delegates to it);
`overrideAccessControlHandler()` throws `InvalidPluginDefinitionException` if none is set. To only
expose provider config without swapping the handler, extend the *basic* `AccessConsumer` instead
(that is what the sibling `adva_na` does to bridge core node grants). See
[../../../../../1.2.x/agent/plugins/access-plugins.md](../../../../../1.2.x/agent/plugins/access-plugins.md).
