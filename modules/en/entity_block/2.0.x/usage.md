Entity Block lets site administrators render any content entity (node, media, block_content, taxonomy term, user, etc.) as a block in a chosen view mode, so the same piece of content can be reused across the site.

---

Entity Block provides a single derivable block plugin (`entity_block`, deriver `EntityBlockDeriver`) that generates one block derivative for every content entity type that has a view builder. When you place one of these blocks you get an entity-autocomplete field to pick the specific entity and a select list of that entity type's view modes; on save the block stores just the entity ID and the view mode, then renders the entity through its normal view builder (`EntityViewBuilder::view()`). The block title is auto-generated from the entity label unless you enable "Display title" and set your own. It merges the referenced entity's cache contexts, cache tags, and max-age into the block so the block updates when the entity changes, and it enforces view access on the entity via `blockAccess()` (returning forbidden when the viewer cannot view it). A recursive-render guard (limit 3) prevents an entity from embedding itself endlessly. Blocks can be placed anywhere blocks are placed — the core Block layout UI or Layout Builder. The module ships config schema for the block settings (`entity`, `view_mode`) but no admin settings form, permissions, services, or submodules. When the optional Canvas module is present it groups/labels view modes by whether a Canvas template exists.

---

- Render a specific node as a block and place it in a sidebar region.
- Reuse one piece of content (e.g. a call-to-action node) across many pages via Block layout.
- Display a media entity as a block in a chosen view mode.
- Show a reusable block_content entity in a non-default view mode.
- Place a taxonomy term's rendered display in a region.
- Embed a user profile entity as a block.
- Add an entity block inside a Layout Builder section.
- Pick the exact entity to show with the entity-autocomplete field when placing the block.
- Choose which view mode the referenced entity renders in (e.g. "teaser", "full", a custom mode).
- Let the block auto-generate its title from the entity label instead of typing one.
- Override the auto title by enabling "Display title" and entering a custom label.
- Surface the same promotional node in multiple regions/pages without duplicating content.
- Build a landing page out of several entity blocks, each showing different content.
- Keep a block's output in sync with the source entity automatically via merged cache tags.
- Ensure the block respects entity view permissions so unauthorized users don't see restricted content.
- Show a "featured article" node teaser in the site header or footer.
- Present a reusable legal/disclaimer node in a footer block across the site.
- Display curated content entities in a Layout Builder-managed node template.
- Add one block per content entity type (any type with a view builder is available).
- Avoid custom code for embedding an entity in a region — configure it entirely in the UI.
- Swap the displayed entity later by editing the block's autocomplete value.
- Group view modes by Canvas template availability when the Canvas module is installed.
- Rely on the built-in recursive-render guard when an entity might reference itself.
- Export/deploy placed entity blocks as configuration (settings hold entity ID + view mode).
