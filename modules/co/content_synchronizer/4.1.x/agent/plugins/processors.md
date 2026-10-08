<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: entity_processor & type_processor

Content Synchronizer defines **two** plugin types that together decide how an entity graph is
serialized into an archive and rebuilt on import. Both are annotation-based (Drupal 11 still uses
the `@EntityProcessor` / `@TypeProcessor` annotations here, not PHP attributes).

## entity_processor — "how to (de)serialize one entity type"

- Manager: `plugin.manager.content_synchronizer.entity_processor`
  (`Processors\Entity\EntityProcessorPluginManager`).
- Discovery dir: `src/Plugin/content_synchronizer/entity_processor/`.
- Interface / base: `Processors\Entity\EntityProcessorInterface` /
  `Processors\Entity\EntityProcessorBase`.
- Annotation: `@EntityProcessor(id = "...", entityType = "node")`.
- Chosen by entity type via `getInstanceByEntityType($entityType)`; falls back to a default
  `EntityProcessorBase` when no plugin matches.

Shipped plugins (in `Plugin/content_synchronizer/entity_processor/`): `NodeProcessor` (node),
`UserProcessor` (user), `TaxonomyTermProcessor` (taxonomy_term), `FileProcessor` (file),
`ParagraphProcessor` (paragraph).

### Add one

```php
namespace Drupal\my_module\Plugin\content_synchronizer\entity_processor;

use Drupal\content_synchronizer\Processors\Entity\EntityProcessorBase;
use Drupal\Core\Entity\EntityInterface;

/**
 * @EntityProcessor(
 *   id = "my_module_media_processor",
 *   entityType = "media"
 * )
 */
class MediaProcessor extends EntityProcessorBase {
  public function getDataToExport(EntityInterface $entityToExport) {
    $data = parent::getDataToExport($entityToExport);
    $data['bundle'] = $entityToExport->bundle();  // customise the exported payload
    return $data;
  }
}
```

(Compare the built-in `NodeProcessor`, which just adds the node's `type` to the payload.)

## type_processor — "how to follow one field/property type"

- Manager: `plugin.manager.content_synchronizer.type_processor`
  (`Processors\Type\TypeProcessorPluginManager`).
- Discovery dir: `src/Plugin/content_synchronizer/type_processor/`.
- Interface / base: `Processors\Type\TypeProcessorInterface` /
  `Processors\Type\TypeProcessorBase` (and `EmbedEntitiesTypeProcessorBase` for reference-like
  fields that must pull the referenced entity into the archive).
- Annotation: `@TypeProcessor(id = "...", fieldType = "Drupal\\Core\\Field\\FieldItemList")`
  — `fieldType` is the field **item-list class** matched against the field.
- Chosen via `getInstanceByFieldType($fieldType)`; falls back to `DefaultTypeProcessor`.

Shipped plugins (in `Plugin/content_synchronizer/type_processor/`): `FieldItemListProcessor`
(base `FieldItemList`), `EntityReferenceFieldItemListProcessor`,
`EntityReferenceRevisionsFieldItemListProcessor`, `FileFieldItemListProcessor`,
`LayoutBuilderProcessor`.

### Add one

```php
namespace Drupal\my_module\Plugin\content_synchronizer\type_processor;

use Drupal\content_synchronizer\Processors\Type\EmbedEntitiesTypeProcessorBase;

/**
 * @TypeProcessor(
 *   id = "my_module_custom_ref_processor",
 *   fieldType = "Drupal\\my_module\\Field\\CustomReferenceItemList"
 * )
 */
class CustomReferenceProcessor extends EmbedEntitiesTypeProcessorBase {
  // Override export/import hooks to control how referenced entities are embedded.
}
```

Both managers use alter hooks `content_synchronizer_entity_processor_info` and
`content_synchronizer_type_processor_info` if you need to alter discovered definitions. Clear
caches (`drush cr`) after adding a plugin so it is discovered.
