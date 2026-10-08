# Read contexts & the context providers

## The `context` entity handler

`hook_entity_type_alter()` assigns every entity type a handler under the `context` key:

- **`FieldContextHandler`** — for entity types implementing `FieldableEntityInterface`.
- **`SettingsContextHandler`** — for config entity types implementing `ThirdPartySettingsInterface`.

Both implement `EntityContextHandlerInterface::getContexts(EntityInterface $entity)`, returning
`\Drupal\Component\Plugin\Context\ContextInterface[]` keyed by the context key, with the host
entity's cache metadata applied.

```php
$entity = /* any entity */;
if ($entity->getEntityType()->hasHandlerClass('context')) {
  $handler = \Drupal::entityTypeManager()
    ->getHandler($entity->getEntityTypeId(), 'context');
  $contexts = $handler->getContexts($entity);   // ['my_flag' => Context(...), ...]
  $value = $contexts['my_flag']->getContextValue();
}
```

- `FieldContextHandler` reads the first `context`-type field's items (keyed by each item's `id`).
- `SettingsContextHandler` reads `getThirdPartySetting('core_context', 'contexts', [])`.

Both convert the stored configs with `ctools.context_mapper->getContextValues()`.

## Context provider services

These implement `ContextProviderInterface`, so anything using the context repository
(`@context.repository`) or context-aware plugins can pick contexts up:

| Service | Class | Exposes |
|---|---|---|
| `core_context` | `ContextProvider\Generic` | Aggregates every service tagged `core_context.context_provider` under one namespace. |
| `core_context.canonical_entity` | `ContextProvider\CanonicalEntity` | Contexts from the entity (and its view display) at a **canonical entity route**. |
| `core_context.layout_builder` | `ContextProvider\LayoutBuilder` | (only if `layout_builder` enabled) contexts while editing a Layout Builder layout. |

`RouteSubscriber` adds `_core_context_entity: node.full` to `entity.node.canonical` so nodes
(whose route lacks `_entity_view`) are covered. `CanonicalEntity` reads `_core_context_entity` or
`_entity_view` (`<entity_type>.<view_mode>`) to know which parameter/view mode to pull.

## Layout Builder integration

When `layout_builder` is present, `CoreContextServiceProvider` also registers
`core_context.render_section_component_subscriber` (`EventSubscriber\SectionComponentRenderArray`,
priority 150 on `SECTION_COMPONENT_BUILD_RENDER_ARRAY`). It finds the section storage's entity,
pulls its contexts via the `context` handler, filters to the ones the component plugin declares,
and calls `$plugin->setContextValue($name, $value)` — so context-aware blocks in a layout receive
the entity's attached contexts. Overrides overlay their contexts on top of the default layout's.

## Extending

- **Add a provider:** register a service implementing `ContextProviderInterface` and tag it
  `core_context.context_provider`; it is collected into the `core_context` Generic provider.
- **Add a handler:** an entity type can supply its own `context` handler class (the alter hook
  skips entity types that already declare one).

No hooks are invited (`core_context` ships no `.api.php`), no Drush, no permissions.
