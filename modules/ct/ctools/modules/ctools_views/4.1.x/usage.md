Chaos Tools Views swaps in an enhanced Views "Block" display so that, when a view is placed as a block, editors get extra per-block controls — items/offset, pager type, which fields to show, and exposed filter overrides.

---

`ctools_views` is an experimental Chaos Tools submodule that improves how core Views blocks behave. It replaces core's Views `Block` display plugin with its own subclass (`Plugin\Display\Block`) via `hook_views_plugins_display_alter()`, adding a richer block-settings form. When you place a view block through the Block Layout UI, you can override the number of items and the offset, choose a pager style, hide or reorder the displayed fields, and set values for exposed filters and sorts directly in the block configuration — without editing the view itself. It extends the `views_block` config schema (through `hook_config_schema_info_alter()`) so those extra settings — `pager`, `fields`, `filter`, `sort_*` — are stored and translatable. It depends on core `block` and `views`, has no admin settings page of its own, and supports Drupal 9.5, 10, and 11. This lets one view display be reused as several differently-configured blocks across a site.

---

- Override the number of items shown by a placed Views block.
- Set a result offset per block instance without touching the view.
- Choose a pager type (full, mini, none) in the block settings form.
- Hide specific fields for one placement of a Views block.
- Reorder fields per block instance via weight settings.
- Provide exposed-filter values directly in a block's configuration.
- Set a default sort for a specific Views block placement.
- Reuse a single view display as several distinct blocks.
- Show a "latest 3" and a "latest 10" block from the same view.
- Configure block-level filter overrides for editors without Views access.
- Store the extra Views-block settings as exportable, translatable config.
- Place a filtered listing block on a landing page with per-page tuning.
- Expose an entity-reference/autocomplete filter value in block config.
- Avoid cloning a view just to change its item count in one region.
- Give site builders granular control over Views blocks in Block Layout.
- Override exposed sort direction on a per-block basis.
- Present the same content list with different fields in different regions.
- Reduce the number of view displays needed for block variations.
- Let a distribution ship one view reused as many configured blocks.
- Keep block-specific Views tweaks out of the shared view definition.
