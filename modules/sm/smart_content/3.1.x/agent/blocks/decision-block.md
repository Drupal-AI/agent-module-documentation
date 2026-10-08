# The Decision Block

Provided by the bundled **smart_content_block** submodule (dependency `smart_content:smart_content`).
This is the normal way personalization is placed on a page. Enable it (and usually
smart_content_browser for browser conditions) to get the block.

## Block plugin

`smart_content_block/src/Plugin/Block/DecisionBlock.php` — `@Block(id =
"smart_content_decision_block", admin_label = "Decision Block")`. Place it via **Block Layout**
(`/admin/structure/block`, needs `administer blocks`) or **Layout Builder**. On construction it
ensures a decision exists, defaulting to the `multiple_block_decision` decision plugin inside a
`config_entity` decision storage.

Key behavior:
- `getDecisionStorage()` lazily builds the decision-storage plugin (default `config_entity`) from the
  block's `decision_storage` config.
- The admin form (`blockForm` → `buildWidget`) embeds the decision plugin's own form (segment set
  select + inline segment/condition/reaction editors) via
  `SegmentSetConfigEntityForm::pluginForm()`, using `DecisionStorageBase::get/setWidgetState()` and
  `WidgetStateHandler` to keep per-segment open/closed state across AJAX rebuilds.
- `blockSubmit()` submits the embedded decision form, then (once validation is complete) stores the
  whole decision-storage object as `decision_storage_serialized` (a `serialize()` of admin-authored
  configuration) in block config. `saveBlockContent()` calls `$storage->save()` to persist the
  decision entity + register its token.
- `build()` renders nothing but a placeholder when a valid segment set is set:
  `['#attributes' => ['data-smart-content-placeholder' => $decision->getPlaceholderId()], '#markup' =>
  ' ']`, then `$decision->attach($build)` adds `drupalSettings.smartContent` + libraries. If the
  segment set is `broken`/unset it renders empty markup. `buildPreview()` shows a labelled
  placeholder (used inside the Layout Builder editor).

Config schema (`smart_content_block.schema.yml`): `block.settings.smart_content_decision_block` →
`decision_storage` mapping (`plugin_id`, `id`). Theme hook
`block__smart_content_decision_block` (template `block--smart-content-decision-block.html.twig`);
`smart_content_block_preprocess_block()` adds the `smart-content-decision-block` class and copies the
`data-smart-content-placeholder` attribute up to the block wrapper.

## Authoring a decision (admin UI)

1. Place a **Decision Block** into a region (Block Layout) or a Layout Builder section.
2. In **Segment settings**, choose a **Global Segment Set** or "+ Create custom segment set" (inline).
3. For each segment: add conditions (Group with AND/OR + child conditions) and configure the segment's
   **Block** reaction (`display_blocks`) — pick the block(s) to show when that segment matches.
4. Optionally mark one segment **default** (shown when no segment matches).
5. Save. At runtime the placeholder is swapped with the winning segment's blocks — see the runtime
   flow in [../plugins/decisions.md](../plugins/decisions.md).

## Integration entity operations

`smart_content_block.module` wires `hook_entity_presave/insert/update/predelete` to
`ConfigBlockEntityOperations`, and (when present) `LayoutBuilderEntityOperations` and
`BlockFieldEntityOperations`, so a decision's storage entity/token lifecycle follows the host block,
Layout Builder component, or `block_field` value. An `event_subscriber`
(`EventSubscriber\LayoutBuilderComponentRenderArray`) handles the Layout Builder component render
array. `block_field` support is a dev-only requirement (`require-dev` in composer.json).
