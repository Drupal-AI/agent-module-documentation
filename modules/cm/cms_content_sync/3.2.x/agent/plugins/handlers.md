<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins: entity handlers & field handlers

Content Sync defines **two plugin types** that decide how each entity and field is
serialized when pushed, and de-serialized when pulled. A Flow picks a handler per entity
type / field; if none is chosen the default handler for that type is used.

## Entity handler — `cms_content_sync_entity_handler`

- Plugin manager: `plugin.manager.cms_content_sync_entity_handler`
  (`src/Plugin/Type/EntityHandlerPluginManager.php`).
- Discovery directory: `src/Plugin/cms_content_sync/entity_handler/`.
- Annotation: `@EntityHandler` (`src/Annotation/EntityHandler.php`; keys `id`, `label`,
  `class`, `weight`).
- Interface / base: `EntityHandlerInterface`, `EntityHandlerBase`
  (`EntityReferenceHandlerBase` for reference-like entities).
- Bundled handlers (`src/Plugin/cms_content_sync/entity_handler/`): `DefaultNodeHandler`,
  `DefaultMediaHandler`, `DefaultFileHandler`, `DefaultTaxonomyHandler`,
  `DefaultMenuLinkContentHandler`, `DefaultCropHandler`, `DefaultGroupContentHandler`,
  `DefaultConfigEntityHandler`, `DefaultContentEntityHandler`, `DefaultCohesionLayoutHandler`.

Implement one by extending a base and declaring `static supports($entity_type, $bundle)`
plus the push/pull methods; place it in your module's
`src/Plugin/cms_content_sync/entity_handler/`. See the `cms_content_sync_custom_field_example`
submodule for a minimal `CustomTaxonomyHandler`.

## Field handler — `cms_content_sync_field_handler`

- Plugin manager: `plugin.manager.cms_content_sync_field_handler`.
- Discovery directory: `src/Plugin/cms_content_sync/field_handler/`.
- Annotation: `@FieldHandler` (`id`, `label`, `weight`).
- Interface / base: `FieldHandlerInterface`, `FieldHandlerBase` (extend
  `DefaultFieldHandler` for most cases).
- Bundled handlers include: `DefaultFieldHandler`, `DefaultEntityReferenceHandler`,
  `MergeableEntityReferenceHandler`, `DefaultFileHandler`, `DefaultLinkHandler`,
  `DefaultPathHandler`, `DefaultFormattedTextHandler`, `DefaultParagraphsReferenceHandler`,
  `DefaultLayoutBuilderHandler`, `DefaultModerationStateHandler`,
  `DefaultWorkflowReferenceHandler`, `DefaultMenuLinkContentReferenceHandler`,
  `DefaultUserReferenceHandler`, `DefaultVideoHandler`, `DefaultWebformHandler`,
  `DefaultComputedFieldHandler`, `DefaultBricksHandler`, `DefaultPanelizerHandler`,
  `DefaultCohesionEntityReferenceHandler`.

Minimal field handler (from the example submodule):

```php
/**
 * @FieldHandler(
 *   id = "cms_content_sync_custom_field_handler",
 *   label = @Translation("Custom"),
 *   weight = 50
 * )
 */
class CustomFieldHandler extends DefaultFieldHandler {
  public static function supports($entity_type, $bundle, $field_name, FieldDefinitionInterface $field) {
    return in_array($field->getType(), ['cs_custom_field']);
  }
}
```

The handler with the highest `weight` whose `supports()` returns TRUE is offered for that
field in the Flow configuration. An `IgnoreFieldHandler` pattern (return no data) is used to
exclude a field from sync entirely.
