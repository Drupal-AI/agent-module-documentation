<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing an EntityViewBuilder plugin

The `EntityViewBuilder` plugin type is how PEVB takes over a bundle's rendering.

## Registration

- **Location:** `src/Plugin/EntityViewBuilder/` in any module.
- **Plugin id MUST be `"{entity_type_id}.{bundle}"`** — this is what the dispatcher looks up
  (`EntityViewBuilderTrait::doBuild()` builds `$entity->getEntityTypeId() . '.' . $entity->bundle()`).
  Examples: `node.article`, `paragraph.card`, `taxonomy_term.tags`.
- **Base class:** extend `Drupal\pluggable_entity_view_builder\EntityViewBuilderPluginAbstract`.
- **Interface:** `EntityViewBuilderPluginInterface` (extends `ContainerFactoryPluginInterface`,
  `PluginInspectionInterface`).
- **Manager service:** `plugin.manager.pluggable_entity_view_builder.entity_view_builder`
  (`EntityViewBuilderPluginManager`, a `DefaultPluginManager`; alter hook
  `pluggable_entity_view_builder_info`, cache key `pluggable_entity_view_builder_plugins`).

Annotation form:

```php
/**
 * @EntityViewBuilder(
 *   id = "node.article",
 *   label = @Translation("Node - Article"),
 *   description = "Node view builder for Article bundle."
 * )
 */
class NodeArticle extends EntityViewBuilderPluginAbstract { ... }
```

Attribute form (`Drupal\pluggable_entity_view_builder\Attribute\EntityViewBuilder`) is also supported:
`#[EntityViewBuilder(id: 'node.article', label: new TranslatableMarkup('Node - Article'))]`.

## View-mode methods

The base `build()` (in `EntityViewBuilderPluginAbstract`) derives the method name from the view mode:

- `default` is remapped to `full` (and `$build['#view_mode']` is set to `full`).
- The view-mode machine name is title-cased and `_`, `-`, space are stripped, then prefixed with
  `build`: `full`→`buildFull`, `teaser`→`buildTeaser`, `search_result`→`buildSearchResult`.
- If the derived method is not callable, `build()` throws `ViewModeNotFoundException`, which the
  dispatcher catches and treats as "no plugin" → **core's default rendering runs for that view mode**.

Each method signature is `public function build{ViewMode}(array $build, EntityInterface $entity): array`
and returns a render array. Append your regions to `$build` (it arrives with `#theme`, `#view_mode`,
`#cache`, etc. already populated) and return it.

```php
public function buildFull(array $build, NodeInterface $entity): array {
  $build[] = $this->buildHeroHeader($entity);
  $build[] = $this->buildProcessedText($entity); // your own trait
  $build[] = [
    '#theme' => 'my_cards',
    '#items' => $this->buildReferencedEntities($entity->field_paragraphs, 'full'),
  ];
  $build['#attached']['library'][] = 'my_theme/component';
  return $build;
}
```

## Dependency injection

`EntityViewBuilderPluginAbstract::create()` already injects `entity_type.manager`, `current_user`,
`entity.repository`, and `language_manager` (available as `$this->entityTypeManager`,
`$this->currentUser`, `$this->entityRepository`, `$this->languageManager`). To add more services
(e.g. for `BuildBlockTrait`), override `create()`, call `parent::create()`, and set your properties —
see `BuildBlockTrait`'s docblock for the block-manager pattern.

## Enabling it

Registering the plugin is not enough: the entity type must be checked on in the settings form
(`enabled_entity_types`) so PEVB swaps in its view-builder class, then rebuild caches. Until then core
renders the bundle normally. Overriding a bundle whose plugin exists makes core's **Manage Display**
UI a no-op for that bundle — `hook_form_entity_view_display_edit_form_alter` adds a warning message to
that effect, naming your plugin class.

## Overriding entity types beyond the built-in map

The settings form only lists `block_content`, `comment`, `media`, `node`, `taxonomy_term`, `user`,
and `paragraph`. To pluggably render any other entity type, implement your own
`hook_entity_type_alter()` that calls `setViewBuilderClass()` with a class using
`EntityViewBuilderTrait` (mirror `pluggable_entity_view_builder_entity_type_alter()`).
