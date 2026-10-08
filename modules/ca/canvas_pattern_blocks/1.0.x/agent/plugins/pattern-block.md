<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin, deriver & rendering flow

## The block plugin
`src/Plugin/Block/PatternBlock.php` — `final class PatternBlock extends BlockBase implements
ContainerFactoryPluginInterface`, declared with the `#[Block]` attribute:
- `id: 'canvas_pattern_block'`, `admin_label: 'Canvas pattern'`, `category: 'Pattern blocks'`,
  `deriver: PatternBlockDeriver::class`.

Injected services (`create()`): `EntityTypeManagerInterface` and a `logger.factory` channel
`canvas_pattern_blocks`.

### defaultConfiguration()
Returns `['label_display' => '0']`. The pattern is fully determined by the config entity, so the
block has no settings of its own — but a default is declared anyway because an input-less block
leaves Canvas's client model undefined and crashes its editor form (mirrors core's
`SystemPoweredByBlock`). `label_display` is hidden because the pattern renders its own heading.
(Test `testBlockExposesExplicitInputToCanvas` asserts the source reports explicit input.)

### build()
1. `getPattern()` resolves the referenced pattern. If it is not a `Pattern`, logs a `warning`
   (`Canvas pattern block %id resolves to no pattern`) and returns `[]`.
2. Otherwise returns `$pattern->getComponentTree()->toRenderable($pattern, FALSE)` — the pattern's
   component tree rendered live by **Canvas core** (`$isPreview = FALSE`, so editor preview and the
   published `/ce-api` output are identical). No markup is assembled by this module; all component
   rendering/escaping is Canvas's responsibility. On decoupled sites the custom_elements render
   converter picks the tree up from the block content and surfaces each component as its own
   custom element.

### Cache metadata
- `getCacheTags()` merges the config entity's tags (`getPatternBlock()->getCacheTags()`) and the
  pattern's tags (`getPattern()->getCacheTags()`) onto the parent's — so both a central pattern
  edit and re-pointing the handle invalidate cached renders (verified by
  `testRepointingPatternInvalidatesBlockCache`).
- `getCacheContexts()` merges the pattern's contexts.

### Private resolvers
- `getPatternBlock()`: loads the `canvas_pattern_block` config entity named by the derivative ID
  (`getDerivativeId()`); returns null if none.
- `getPattern()`: loads the `pattern` storage entity by `getPatternBlock()?->getPatternId()`.

## The deriver
`src/Plugin/Derivative/PatternBlockDeriver.php` — `final class PatternBlockDeriver extends
DeriverBase implements ContainerDeriverInterface`. `getDerivativeDefinitions()` loads all
`canvas_pattern_block` entities via `EntityTypeManagerInterface` and creates one derivative per
entity keyed by its ID, setting `admin_label` to the entity label. Result: block plugin IDs of the
form `canvas_pattern_block:<config_entity_id>`.

## Keeping Canvas in sync
`CanvasPatternBlock::postSave()` and `::postDelete()` both call the static `refreshComponents()`,
which:
- `\Drupal::service('plugin.manager.block')->clearCachedDefinitions()` — refresh block derivatives,
- `\Drupal::service(ComponentSourceManager::class)->generateComponents('block')` — regenerate the
  Canvas `Component` config entities so the block appears/updates in Canvas's component library
  (Canvas only lists a block once a matching `Component` exists).

## Notes for agents
- There is no `.module`, `.install`, `.services.yml`, or `config/install/` — the module is
  entirely attribute-driven plugins + one config entity + schema + permission + menu/action links.
- To place programmatically, create the block via `plugin.manager.block`
  `->createInstance('canvas_pattern_block:<id>')`.
