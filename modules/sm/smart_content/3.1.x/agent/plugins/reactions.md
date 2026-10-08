# Reaction plugins

A **Reaction** is what happens when a segment evaluates true: it returns an `AjaxResponse` that the
client-side agent applies to the page. Each reaction is bound to exactly one segment (by the
segment's UUID).

## Manager

| Service id | Class | Plugin dir | Interface | Annotation |
|---|---|---|---|---|
| `plugin.manager.smart_content.reaction` | `Reaction\ReactionManager` | `Plugin/smart_content/Reaction` | `Reaction\ReactionInterface` | `@SmartReaction` |

Alter hook: `hook_smart_content_reaction_info`. The core `smart_content` module defines the reaction
plugin *type* and base classes but ships **no** reaction plugin itself — the only bundled reaction is
`display_blocks`, provided by the **smart_content_block** submodule.

## `ReactionInterface` / `ReactionBase`

`Reaction\ReactionBase` (abstract; `ContextAwarePluginInterface`, `ConfigurableInterface`,
`AttachedJavaScriptInterface`) key methods:

| Method | Purpose |
|---|---|
| `getSegmentDependencyId()` / `setSegmentDependency(Segment)` | The reaction stores only the segment **UUID** (`segment_id`), never the Segment object. |
| `getResponse(PlaceholderDecisionInterface $decision)` | Build and return the `AjaxResponse` (the actual work). |
| `getAttachedSettings()` | Emits `['id' => <segmentUuid>]` (+ `contexts` if the reaction implements `ReactionContextRequirementsInterface`) into `drupalSettings`. |
| `getPlainTextSummary()` / `getHtmlSummary()` | Admin summaries. |
| `getLibraries()` | JS libraries to attach. |

`ReactionConfigurableBase` adds `PluginFormInterface` for reactions with an admin form. Stored config
schema (`smart_content.reaction.schema.yml`): `id`, `segment_id`.

`ReactionContextRequirementsInterface` marks reactions that process multiple contexts; combined with
a decision implementing `PluginContextParamConverterInterface` (from the separate
`smart_content_view_mode` project, not bundled here), the AJAX endpoint forwards
`_sc_context_*` query params into the reaction. The bundled `multiple_block_decision` does **not**
implement that interface, so context params are inert with only this package installed.

## The bundled `display_blocks` reaction

`smart_content_block/src/Plugin/smart_content/Reaction/DisplayBlocks.php` (`@SmartReaction id =
"display_blocks"`, label "Block"). It holds a collection of core **Block plugins** (a
`BlockPluginCollection`) chosen by the admin. Highlights:

- `buildConfigurationForm()` lists blocks via `blockManager->getDefinitionsForContexts(...)`,
  omitting `extra_field_block`, `inline_block`, `page_title_block`, `smart_content_decision_block`
  and any `layout_builder`-provided block; admins add/remove/reorder blocks (AJAX table).
- Config is serialized as `blocks` (a `sequence` of `block.settings.[id]`), schema
  `smart_content.reaction.plugin.display_blocks` in `smart_content_block.schema.yml`.
- `getResponse()` builds a render array per configured block (`#theme => 'block'`, `content =>
  $block->build()`) and returns a `ReplaceCommand` targeting
  `[data-smart-content-placeholder="<decision placeholderId>"]`, wrapped in a
  `CacheableAjaxResponse`. Block cacheability is merged into the response.

## Add a reaction plugin

1. `src/Plugin/smart_content/Reaction/MyReaction.php` with `@SmartReaction(id="…", label=…)`.
2. Extend `ReactionBase` (or `ReactionConfigurableBase` for an admin form).
3. Implement `getResponse(PlaceholderDecisionInterface $decision)` to return an `AjaxResponse` /
   `CacheableAjaxResponse`; use `$decision->getPlaceholderId()` to target the placeholder element.
4. Implement `getConfiguration()/setConfiguration()` to persist your settings alongside the base
   `id`/`segment_id`, and add a matching `smart_content.reaction.plugin.<id>` config schema.
5. `getResponse()` runs from the client-side decision endpoint, so build the render array for the
   resolved segment and return it as the AjaxResponse command.
