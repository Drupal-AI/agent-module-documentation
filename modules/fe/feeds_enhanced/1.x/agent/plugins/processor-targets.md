<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Enhanced — processor & multi-value targets

## Global swap-in (feeds_enhanced.module)

- `hook_feeds_processor_plugins_alter(&$info)`: `array_walk` sets **every** processor's `class` to
  `EnhancedContentEntityProcessor::class`. So after enabling the module, all Feed Types use the
  enhanced processor transparently (plugin IDs, e.g. `entity:node`, are unchanged).
- `hook_feeds_target_plugins_alter(&$info)`: for each `AlternateTargetPlugin` enum case, sets
  `$info[$case->value]['class'] = $case->classFQDN()`, replacing the 20 stock Feeds targets with the
  subclasses in `src/Feeds/Target/`.

## EnhancedContentEntityProcessor

`src/Feeds/Processor/EnhancedContentEntityProcessor.php`, extends Feeds
`GenericContentEntityProcessor`. Adds accumulation of multi-value field values across imports.

- `defaultConfiguration()` adds `collect_multi_values => FALSE`.
- `map(feed, entity, item)` override:
  1. `setTargets($feed->getType()->getMappings())` — indexes mapping data by target field name.
  2. `collectOriginalValues($entity)` — snapshots current values of fields that
     `supportsMultiValue()`.
  3. `parent::map()` — normal Feeds mapping (may replace field values).
  4. `mergeMultiValues($entity, $originals)` — re-appends any original values dropped by mapping,
     using `array_diff` on the field's property (`value` / `target_id`, from `getFieldProperty()` =
     first key of the mapping's `map`), stopping at cardinality via `fieldHasRoom()`
     (`$field->count() < cardinality` or `CARDINALITY_UNLIMITED`).
- `supportsMultiValue($field)` is TRUE when `getCardinality($field) !== 0 && !== 1`, where
  `getCardinality()` reads the per-mapping setting `settings.collect_multi_values` (defaults to 1).
  So collection is opt-in per mapping and only for multi-value fields.

Net effect: existing `[tag1, tag2]` + imported `[tag3]` → `[tag1, tag2, tag3]` instead of `[tag3]`,
capped by the field's cardinality.

### Config-type repair (Updater / update_9001)

`feeds_enhanced.install`'s `feeds_enhanced_update_9001()` calls
`Updater::getService()->fixProcessorConfigurationTypes()` (`src/Updater.php`, service
`feeds_enhanced.updater`). Earlier schema wrongly typed some processor settings as boolean; the
routine scans `feeds.feed_type.*`, and for `entity:` processors resets boolean-corrupted
`update_non_existent` → `'_keep'`, `insert_new` → 1|2, `update_existing` → 1|0, `expire` → -1
(EXPIRE_NEVER), logging a notice and warning that `update_non_existent` may need manual reset.
Schema for the processor is `feeds.processor.entity` in `config/schema/feeds_enhanced.schema.yml`.

## Replacement targets (multi-value trait)

`src/Feeds/Target/` — one subclass per stock Feeds target, each extending the core Feeds target and
adding `FeedTargetSupportsMultiValueTrait` (+ `FeedTargetSupportMultiValueInterface`). Enum
`AlternateTargetPlugin` maps plugin id → class. Covered ids: `book`, `boolean`,
`config_entity_reference`, `daterange`, `datetime`, `email`, `entity_reference`, `file`, `image`,
`integer`, `link`, `number`, `password`, `path`, `string`, `telephone`, `text`, `timestamp`, `uri`,
`user_role`.

`FeedTargetSupportsMultiValueTrait` (`src/Feeds/Target/FeedTargetSupportsMultiValueTrait.php`):
- Adds config key `collect_multi_values` (`multiValuePropertyName()`), default FALSE.
- On fields with cardinality ≠ 1, `buildConfigurationForm()` prepends a **"Collect multiple values"**
  checkbox (`#return_value => cardinality`); `getSummary()` shows its state; for cardinality-1
  fields it falls back to the parent form/summary unchanged.
- `supportsMultiValue()` is TRUE when the stored value is neither FALSE nor `1`.
- `getCardinality()` reads the target field's storage-definition cardinality.

So multi-value collection is configured per field mapping (the checkbox) and honored by the
processor's `map()` merge above.
