# Services & Twig

## Services
- `entity_embed.builder` (`EntityEmbedBuilder`, interface `EntityEmbedBuilderInterface`) —
  builds the render array for an embedded entity.
  - `buildEntityEmbed(EntityInterface $entity, array $context = [])` → render array.
  - `buildEntityEmbedDisplayPlugin($plugin_id, EntityInterface $entity, $mode, array $settings)`.
- `plugin.manager.entity_embed.display` (`EntityEmbedDisplayManager`) — discover/instantiate
  EntityEmbedDisplay plugins; `getDefinitionOptionsForEntity($entity)` lists allowed plugins.
- `entity_embed.twig.entity_embed_twig_extension` (`EntityEmbedTwigExtension`) — registers
  the Twig function below.

## Twig
Embed an entity from any template:
```twig
{{ entity_embed('node', 'uuid-or-id', 'view_mode:node.teaser', {"view_mode": "teaser"}) }}
```
Args: entity type id, entity id/uuid, EntityEmbedDisplay plugin id, display settings map.

## Programmatic build
```php
$builder = \Drupal::service('entity_embed.builder');
$build = $builder->buildEntityEmbed($node, [
  'data-entity-embed-display' => 'view_mode:node.teaser',
  'data-entity-embed-display-settings' => ['view_mode' => 'teaser'],
]);
```
