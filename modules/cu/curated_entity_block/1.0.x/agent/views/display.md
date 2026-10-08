<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Curated entity block" Views display

Views display plugin `curated_entity_block` in
`src/Plugin/views/display/CuratedEntityBlock.php`, extending core's `EntityReference` display
(`#[ViewsDisplay(... entity_reference_display: TRUE)]`). One such display is both the block's
selection pool and the source the deriver turns into a placeable block (see
[../blocks/curated-entity-block.md](../blocks/curated-entity-block.md)).

## Site-builder setup

1. Create or reuse a **View** on the entity type you want to curate.
2. Add a **Curated entity block** display.
3. Shape the curation on that display:
   - **filters / sort / access** define which entities an editor may pick (the pool);
   - the Entity Reference **Search fields** drive the editor's autocomplete;
   - **Allowed view modes** limits which view modes the editor may choose;
   - **Entity rendering** = Default or Custom Element;
   - **Number of entities** = optional minimum / maximum / step.
4. Save. A block named after the display is now placeable (Block Layout and Drupal Canvas).

An editor who places the block without picking anything sees the view's own first results, so it
renders immediately, then overrides with hand-picked, ordered entities.

## Display options (`defineOptions`)

Added on top of the Entity Reference display's own options:

| Option | Default | Meaning |
|---|---|---|
| `allowed_view_modes` | `[]` | Machine names of view modes an editor may choose. Empty = all. |
| `render_mode` | `'default'` | `default` (entity view builder / HTML) or `custom_element` (render each entity as a Custom Element). |
| `min_entities` | `NULL` | Fewest entities an editor must pick. Empty = no minimum. |
| `max_entities` | `NULL` | Most entities an editor may pick; also caps the no-selection fallback. Empty = no maximum. |
| `step_entities` | `NULL` | Restrict the count to multiples of this step above the minimum (min 3 + step 3 ⇒ 3, 6, 9). Empty = any count. |

These appear on the display's *settings* panel under a **"Curated entity block settings"** category
(`optionsSummary()`), each with its own section form (`buildOptionsForm()`/`submitOptionsForm()`):

- **Allowed view modes** — checkboxes of the target entity type's view modes.
- **Entity rendering** — radios; the **Custom Element** option only appears when the
  `custom_elements` module is installed (`getRenderModeOptions()` via `moduleHandler`).
- **Number of entities** — three number fields (min `#min 0`, max `#min 1`, step `#min 1`), stored as
  `NULL` when left blank else `(int)`.

`getEntityCountSummary()` renders the count summary (e.g. `min 3, max 9, step 3`, or `Any`).
`getTargetEntityTypeId()` returns the view's base entity type id, used to list view modes.

## Dependencies

`calculateDependencies()` adds a hard `custom_elements` module dependency **only** when
`render_mode` is `custom_element`; otherwise the display (and its blocks) need only `views`.

## Config schema

`config/schema/curated_entity_block.schema.yml` defines `views.display.curated_entity_block`
(type `views.display.entity_reference`) with: `allowed_view_modes` (sequence of strings),
`render_mode` (Choice: `default`|`custom_element`), and nullable `min_entities` (Range min 0),
`max_entities` (Range min 1), `step_entities` (Range min 1). It also defines the block settings
schema `block.settings.curated_entity_block:*` (see the block doc).

## The example View

Installed from `config/install/views.view.curated_entities_example.yml`: id `curated_entities_example`,
label "Curated entities", base table `node_field_data`. Its `default` display filters
`status = 1` (published) and sorts `created DESC`; the `curated_entity_block_1` display uses
`display_plugin: curated_entity_block` with `style: entity_reference` (search field `title`),
`allowed_view_modes: {}` (all) and `render_mode: default`. It is a starter pool — alter or remove it
as needed. The example depends on `node`, so it is only meaningful on sites with the Node module.

## How the block reads these back

The deriver bakes only `render_mode` into the block derivative. The block reads `allowed_view_modes`
and the entity-count bounds **live** off the display at configure/validate time via
`getDisplayOptions()`, so changing the display updates the block's picker constraints without
rebuilding derivatives.
