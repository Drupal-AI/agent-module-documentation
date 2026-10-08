# Decision, DecisionStorage & SegmentSetStorage plugins + the runtime flow

A **Decision** is the orchestrator: it holds a Segment Set (via a segment-set-storage plugin) and a
Reaction per segment, owns the per-instance **token**, and produces the `drupalSettings` the JS agent
consumes. A **DecisionStorage** plugin persists a decision (as a config or content entity) and maps
tokens ↔ decisions. A **SegmentSetStorage** plugin supplies the Segment Set (inline or a reusable
global one).

## Managers

| Service id | Class | Plugin dir | Interface | Annotation |
|---|---|---|---|---|
| `plugin.manager.smart_content.decision` | `Decision\DecisionManager` | `Plugin/smart_content/Decision` | `Decision\DecisionInterface` | `@SmartDecision` |
| `plugin.manager.smart_content.decision_storage` | `Decision\Storage\DecisionStorageManager` | `Plugin/smart_content/Decision/Storage` | `Decision\Storage\DecisionStorageInterface` | `@SmartDecisionStorage` |
| `plugin.manager.smart_content.segment_set_storage` | `SegmentSetStorage\SegmentSetStorageManager` | `Plugin/smart_content/SegmentSetStorage` | `SegmentSetStorage\SegmentSetStorageInterface` | `@SmartSegmentSetStorage` |

`SegmentSetStorageManager` implements `FallbackPluginManagerInterface` (fallback `broken`) and
`getFormOptions($include_custom = TRUE)` — lists all `global => true` definitions plus `inline`.
Alter hooks: `hook_smart_content_decision_info`, `hook_smart_content_decision_storage_info`,
`hook_smart_content_segment_set_storage_info`.

## Decision plugins

`Decision\DecisionBase` (abstract; `ContainerFactoryPluginInterface`, injects the segment-set-storage
manager, reaction manager, event dispatcher, uuid generator). Responsibilities:

- **Token**: a UUID generated on construction if absent; `getToken()`, `refreshToken()`,
  `getUniqueFormId($suffix)`.
- **Reactions**: `getReactions()` (a `ReactionPluginCollection`), `getReaction($id)`,
  `hasReaction($id)`, `setReaction()`, `appendReaction()`, `removeReaction()`.
- **Segment set**: `setSegmentSetStorage()`, `getSegmentSetStorage()`.
- `getResponse(ReactionInterface $reaction)` → delegates to the matching reaction's `getResponse()`.
- `getAttachedSettings()` — the heart of the client contract. It builds
  `segments` (from `getSegmentSetStorage()->getSegmentSet()->getSegments()`, weight-ordered) and a
  `decisions[<token>]` entry containing `token`, `storage` (the decision-storage id), and
  `reactions[<segmentUuid>]` = each reaction's attached settings. It then dispatches
  `AttachDecisionSettingsEvent` (`attach_decision_settings`) so other modules can alter the payload.
- `attach(array $element)` — attaches `drupalSettings.smartContent`, libraries
  (`smart_content/smart_content` + condition libraries), and the segment set's cacheability.
- Config schema (`smart_content.schema.yml`, `settings` mapping): `id`, `default` (default segment
  id), `segmentStorage` (a `smart_content.segment_storage.plugin.[id]`), `token`, `storage_id`,
  `reactions` (sequence of `smart_content.reaction.plugin.[id]`).

Bundled decision: **`multiple_block_decision`** (smart_content_block, implements
`PlaceholderDecisionInterface`) — the admin widget that lets you pick a segment set, edit
segments/conditions inline, and attach a `display_blocks` reaction to each segment.
`getPlaceholderId()` gives the DOM target for reactions.

## DecisionStorage plugins

`DecisionStorageInterface` methods: `getDecision()/setDecision()/hasDecision()`, `save()`, `delete()`,
`isNew()`, `setNewRevision()`, `registerToken()`, `deleteTokens()`, `loadDecisionFromToken($token)`.
Two bundled plugins (`Plugin/smart_content/Decision/Storage/`):

| id | Class | Backing entity | Token table | Notes |
|---|---|---|---|---|
| `config_entity` | `ConfigEntity` | `DecisionConfig` (config entity) | `decision_config_token` | Default for block placement; exportable with the config it lives in. Handles config-import token sync (`importerProcess`/`importerFilter`, wired via `hook_config_import_steps_alter`). |
| `content_entity` | `ContentEntity` | `DecisionContent` (revisionable, translatable content entity) | `decision_content_token` | For decisions nested in content entities; tracks parent usage in `decision_content_usage` for orphan cleanup. |

`loadDecisionFromToken($token)` queries the token table (`decision_*_token`) for the UUID, loads the
entity, and the entity yields the decision. `registerToken()` inserts the token row at save.

## SegmentSetStorage plugins

`SegmentSetStorageBase::getSegmentSet()`/`load()` return a `SegmentSet`. Bundled:

| id | Class | `global` | Source |
|---|---|---|---|
| `inline` | `Inline` | false | Segment set stored inline in the decision config (`settings.segments`). Label "+ Create custom segment set". |
| `global_segment_set` | `GlobalSegmentSet` | true | Derived (one per `SegmentSetConfig` entity) via `GlobalSegmentSetDeriver`; plugin id is `global_segment_set:<entity_id>`. Implements `CacheableDependencyInterface`. |
| `broken` | `Broken` | — | Fallback. |

Saving/deleting a `SegmentSetConfig` clears the segment-set-storage manager's cached definitions so
the deriver stays in sync.

## End-to-end runtime flow

1. **Render (server).** A Decision Block builds a placeholder `<div
   data-smart-content-placeholder="…">` and calls `Decision::attach()`, which puts
   `drupalSettings.smartContent` (segments + `decisions[<token>]`) and the JS libraries on the page.
   The host markup is static, so the page remains cacheable.
2. **Evaluate (browser).** `js/smart_content.js` runs `Drupal.smartContent.init(settings)`:
   - `processSegments()` registers each segment in `segmentManager`; each condition's client
     **Field** collector (`Drupal.smartContent.plugin.Field[pluginId]`) fetches the browser value and
     the **ConditionType** evaluator (`…plugin.ConditionType[type]`) returns true/false (with
     `negate` applied). A `group` condition resolves AND/OR over its children (early-return via
     `promiseRaceMatch` in `condition.common.js`).
   - `processDecisions()` awaits each segment (by reaction id = segment UUID) in weight order and
     picks the **first** true segment as the winner; if none match and a `default` is set, the
     default segment wins.
3. **React (AJAX).** `processWinner()` GETs
   `/<base>/ajax/smart_content/<storage>/<token>/<winnerReactionId>` (appending any
   `_sc_context_*` params for context-aware reactions) via a wrapped `Drupal.ajax` call, then
   dispatches a `smart_content_decision` window event `{winner, default, settings}`.
4. **Respond (server).** `ReactionController::getReactionResponse()` validates that `token` and
   `reaction` are UUIDs, `loadDecisionFromToken()` rebuilds the decision, and returns the winning
   reaction's `AjaxResponse` (for `display_blocks`, a `ReplaceCommand` swapping the placeholder for
   the rendered blocks). See [../api/services.md](../api/services.md) for the endpoint and the
   cacheable-AJAX layer.

`js/smart_content.storage.js` provides `Drupal.smartContent.storage`, a `localStorage`-backed
key/value store (bin `_scs`, per-item expiration) used by conditions such as UTM/cookie signals.

## Add a decision or storage plugin

- **Decision**: extend `Decision\DecisionBase`, annotate `@SmartDecision`, implement the admin form
  (`buildConfigurationForm`) and (usually) `PlaceholderDecisionInterface::getPlaceholderId()`.
- **DecisionStorage**: extend `DecisionStorageEntityBase`, annotate `@SmartDecisionStorage`, and
  implement `loadDecisionFromToken()`, `registerToken()`, `deleteTokens()` against your token store.
- **SegmentSetStorage**: extend `SegmentSetStorageBase`, annotate `@SmartSegmentSetStorage` (set
  `global` and, for entity-backed sets, a `deriver`), implement `load()` → `SegmentSet`.
