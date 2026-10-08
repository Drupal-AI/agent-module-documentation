# Services, entities, field type, events & the reaction endpoint

## Plugin managers (services.yml)

All seven managers extend `default_plugin_manager`. Ids:
`plugin.manager.smart_content.condition`, `.condition_type`, `.condition_group`, `.reaction`,
`.decision`, `.decision_storage`, `.segment_set_storage`. Plugin type details are in
[../plugins/conditions.md](../plugins/conditions.md), [../plugins/reactions.md](../plugins/reactions.md)
and [../plugins/decisions.md](../plugins/decisions.md).

Other services:

| Service id | Class | Role |
|---|---|---|
| `smart_content.param_converter` | `Routing\DecisionStorageParamConverter` | ParamConverter (tag `paramconverter`, priority 10) for route param type `decision_storage` → instantiates the decision-storage plugin named in the URL. |
| `smart_content.theme.negotiator.cacheable_ajax_base_page` | `Cache\CacheableAjaxBasePageNegotiator` | Theme negotiator (priority 1100) so the reaction AJAX responses render with the right theme while staying cacheable. |
| `ajax_response.attachments_processor.smart_content` | `Cache\CacheableAjaxResponseAttachmentsProcessor` | Decorates `ajax_response.attachments_processor` to support the cacheable AJAX response. |

## The reaction endpoint

Route `smart_content.reaction` (`smart_content.routing.yml`):

```
path: /ajax/smart_content/{decision_storage}/{token}/{reaction}
controller: Controller\ReactionController::getReactionResponse
requirements: { _permission: 'access content' }
options.parameters.decision_storage.type: decision_storage
```

`getReactionResponse(DecisionStorageInterface $decision_storage, $token, $reaction)`:
1. Requires `Uuid::isValid($token)` **and** `Uuid::isValid($reaction)`.
2. `$decision_storage->loadDecisionFromToken($token)` → `$decision_storage->getDecision()`.
3. Extracts `_sc_context_*` query params into a context array.
4. If `$decision->hasReaction($reaction)`, returns `$reaction->getResponse($decision)` (mapping
   contexts first when the decision implements `PluginContextParamConverterInterface`).
5. Otherwise returns an empty `CacheableAjaxResponse`.

The `{decision_storage}` and token are emitted client-side by `Decision::getAttachedSettings()`; the
token is a per-instance random UUID stored in `decision_config_token` / `decision_content_token`.

## Entities

| Entity type id | Class | Kind | Config prefix / tables |
|---|---|---|---|
| `smart_content_decision_config` | `Entity\DecisionConfig` | Config entity (`EntityWithPluginCollectionInterface`, `DecisionEntityInterface`) | prefix `smart_content.smart_content.decision`; `config_export = {id, settings}`; `admin_permission = administer smart content`. |
| `smart_content_decision_content` | `Entity\DecisionContent` | Content entity (revisionable, translatable) | tables `smart_content_decision*`; base field `settings` of type `smart_content_decision`. |
| `smart_content_segment_set` | `Entity\SegmentSetConfig` | Config entity | prefix `smart_content.smart_content.segment_set`; `config_export = {id, label, uuid, settings}`; forms/list-builder/route-provider (see [../configure/segment-sets.md](../configure/segment-sets.md)). |

`DecisionEntityInterface`: `getDecision()`, `hasDecision()`, `setDecision(DecisionInterface)` — the
common contract both decision entities expose so `DecisionStorage` plugins can treat them uniformly.

## Field type & data type (internal)

- Field type `smart_content_decision` (`Plugin/Field/FieldType/DecisionItem.php`, `no_ui`,
  `@internal`). Single main property `decision`; DB column is a serialized `blob`. Helpers
  `getDecision()` / `setDecision(DecisionInterface)` marshal between the stored config array and a
  live decision plugin instance (via `plugin.manager.smart_content.decision`).
- Data type `smart_content_decision` (`Plugin/DataType/DecisionData.php`, `@internal`) wraps a
  `DecisionInterface`; `setValue()` accepts a decision object or a config array (with an `id`).

## Value objects (not plugins/entities)

- `Segment` (`src/Segment.php`) — a UUID + a `ConditionPluginCollection` + `weight`/`label`/`default`.
  `toArray()`/`fromArray()`, `getAttachedSettings()` (emits `{uuid, conditions:[…]}`),
  `getLibraries()`. Uses `ObjectWithConditionPluginCollectionInterface` + `ConditionsHelperTrait`.
- `SegmentSet` (`src/SegmentSet.php`) — an ordered map of `Segment` by UUID with CRUD, `sortSegments()`
  (by weight), `getDefaultSegment()/setDefaultSegment()`, deep `__clone`, `toArray()/fromArray()`,
  and aggregate `getAttachedSettings()/getLibraries()`.

## Events

`Event\AttachDecisionSettingsEvent` (name constant `attach_decision_settings`, value
`'attach_decision_settings'`). Dispatched by `DecisionBase::getAttachedSettings()` with the settings
array passed **by reference**; subscribe and call `$event->getSettings()` (returns a reference) to add
or alter the `drupalSettings.smartContent` payload before it reaches the browser (this is how
sibling modules like the datalayer integration inject extra data).

## Hooks the module implements

- `hook_entity_delete` (`smart_content.module`) → `RevisionableParentEntityUsageCleanup::handleDelete()`
  removes orphaned `content_entity` decisions when their parent entity is deleted; ordered last via
  `hook_module_implements_alter`.
- `hook_config_import_steps_alter` → adds a sync step that keeps `decision_config_token` rows in step
  with imported/deleted decision config entities.
