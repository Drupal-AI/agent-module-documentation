Entity Browser Block turns every Entity Browser on your site into a placeable block: you pick one or more entities through that browser's UI, choose a view mode per entity, and the block renders them wherever blocks go (theme regions, Layout Builder, Panels).

---

The module provides a single derivable block plugin, `entity_browser_block`, whose deriver (`EntityBrowserBlockDeriver`) creates one block derivative for every `entity_browser` config entity on the site — the plugin id is `entity_browser_block:{browser_machine_name}` and the derivative is labelled with the browser's label. When you place one of these blocks its configuration form embeds the matching Entity Browser (an `#type => entity_browser` element) so you select entities exactly as that browser is set up to do; a drag-sortable table then lets you order the chosen entities and pick a **view mode** for each one. The block stores just two settings: `entity_ids` (an ordered list of `entity_type:entity_id` strings, e.g. `node:1`) and `view_modes` (a map keyed by that same `entity_type:entity_id` string to the view-mode machine name). At render time `build()` loads each entity and renders it through its normal view builder in the stored view mode, merging each entity's cache metadata and enforcing `view` access per entity, with a recursive-render guard (limit 2) to stop an entity embedding itself endlessly. It has no admin settings form, no `configure` route, no permissions, no services, and no submodules — an Entity Browser must exist first, because the deriver keys blocks off browsers. Placed blocks are configuration and declare dependencies on the referenced entities, their view-mode displays, and the browser, so they export and deploy cleanly.

---

- Place a block that shows one or more nodes selected through an Entity Browser.
- Embed a set of media items chosen via a media Entity Browser into a region.
- Curate a hand-picked list of entities and render each in a different view mode.
- Reuse the same Entity Browser you already use in fields to also build blocks.
- Show a "featured" node as a full-view-mode block and others as teasers in one block.
- Order the selected entities with the drag-and-drop weight table before saving.
- Render selected entities inside a Layout Builder section as a block.
- Place the block in a Panels/Panelizer layout that accepts blocks.
- Build a promotional sidebar out of a few curated media or node entities.
- Choose the view mode per entity (e.g. `teaser`, `full`, or a custom mode) independently.
- Add multiple different entity types to one block if the browser can select them.
- Swap the displayed entities later by editing the block and re-selecting in the browser.
- Get one block derivative automatically for each Entity Browser you create.
- Keep block output in sync with source entities via merged cache tags/contexts.
- Respect per-entity view permissions so restricted content is hidden automatically.
- Deploy curated content blocks as configuration with `drush config:export`.
- Remove an individual entity from the selection with the row's Remove button.
- Present editorially-selected "related content" without writing a view or query.
- Use an iframe/modal/standalone Entity Browser display to pick block content.
- Render the same reusable entity in several regions by placing several blocks.
- Avoid custom code for embedding chosen entities — configure it entirely in the UI.
- Let the recursive-render guard protect against an entity that references itself.
