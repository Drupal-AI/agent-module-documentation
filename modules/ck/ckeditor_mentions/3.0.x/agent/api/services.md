# Service API

## `ckeditor_mentions.mention_event_dispatcher`
Class `Drupal\ckeditor_mentions\MentionEventDispatcher` (marked `@internal`). Finds mentions
inside an entity's formatted-text fields and dispatches [mention events](../events/events.md).
Uses `masterminds/html5` to parse the stored HTML.

| Method | Signature | Purpose |
|---|---|---|
| `dispatchMentionEvent` | `(EntityInterface $entity, string $event_name): void` | For each mention in `$entity`, dispatch a `CKEditorMentionsEvent` under `$event_name`. Called from the module's entity insert/update hooks. |
| `getMentionsFromEntity` | `(EntityInterface $entity): array` | Iterates `_editor_get_formatted_text_fields($entity)`, skips fields whose format is not mentionable, and returns mention records `['anchor' => DOMElement, 'plugin' => MentionsTypeBase, 'entity' => loaded target, 'field_info' => [...]]`. |
| `getMentionedEntities` | `(string $html): array` | Parses `<a>` tags; for those with both `data-entity-uuid` and `data-plugin`, resolves the mentions-type plugin and loads the target via `EntityRepository::loadEntityByUuid()`. Returns `['anchor', 'plugin', 'entity']` per mention. |
| `isFormatMentionable` | `(string $format_id): bool` | TRUE if the format's CKEditor 5 editor has at least one enabled mentions type. Cached in bin `ckeditor_mentions` keyed `ckeditor_mentions:mentionable_formats:{format}`, invalidated by editor list cache tags. |

Example — list who is mentioned in a node:
```php
$svc = \Drupal::service('ckeditor_mentions.mention_event_dispatcher');
foreach ($svc->getMentionsFromEntity($node) as $m) {
  $target = $m['entity'];       // e.g. the mentioned user
  $plugin = $m['plugin'];       // the MentionsType plugin
}
```

## `plugin.manager.mentions_type`
The mentions-type plugin manager. See [plugins/mentions-type.md](../plugins/mentions-type.md).
`getAllMentionsTypes(): array` → `[id => label]`.

## Cache services (`ckeditor_mentions.services.yml`)
- `cache.ckeditor_mentions` — a `BackendChain` (memory `cache.ckeditor_mentions.memory` + `cache.default`), tagged as a cache bin `ckeditor_mentions`. Injected into the mention event dispatcher and used for the mentionable-format lookup.

## Autocomplete controller
`Controller\CKMentionsController::getMatch($editor_id, $plugin_id, $match)` — the route callback
that returns JSON suggestions by instantiating the mentions-type plugin and calling
`buildResponse()`. Details in [plugins/mentions-type.md](../plugins/mentions-type.md).
