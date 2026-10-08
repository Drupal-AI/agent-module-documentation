Block Field adds a `block_field` field type that lets editors place and configure any Drupal block plugin (core, contrib, custom, or Views block) directly inside a content entity, per node/entity.

---

Normally a Drupal block is positioned once in a theme region and shown site-wide; Block Field turns blocks into a per-entity field value instead. Add a **Block field** to any content type (or other fieldable entity) and, when editing content, the author picks a block plugin from a select list and fills in that block's own configuration form (label, and any settings the block exposes). The chosen block is stored as `plugin_id` plus a serialized settings array, and rendered inline wherever the field is displayed. Which blocks are offered is controlled per field by a **selection handler** — a `BlockFieldSelection` plugin — shipped in two flavours: **Blocks** (whitelist specific block plugin IDs) and **Categories** (allow every block in chosen categories). The module provides the field type, a widget, and two formatters (render the block, or show just its admin label). Developers can add new selection strategies by writing a `BlockFieldSelection` plugin and can fetch the configured block instance in code via `BlockFieldItem::getBlock()`. It is a popular building block for flexible layouts, letting editors compose pages from reusable block components without a full page-builder.

---

- Let editors drop a "Contact" or "Newsletter signup" block into a specific node.
- Add a configurable call-to-action block per landing page.
- Place a Views block (e.g. "Related articles") inside an article and configure its arguments.
- Build a flexible page where each section is a block chosen by the author.
- Restrict a field to only a curated whitelist of approved block plugins.
- Restrict a field to every block within chosen categories (e.g. all "Menus" blocks).
- Reference a custom/content block created via core's Block Content in a node field.
- Embed a search form block on selected pages only.
- Add a hero/banner block that editors configure per campaign.
- Give a paragraph or media entity its own block field for modular content.
- Render the selected block inline with the default formatter.
- Display just the block's admin label (e.g. in a teaser) with the label formatter.
- Provide multiple block-field deltas so an author stacks several blocks in order.
- Set a default block for a field so new content starts pre-populated.
- Configure block visibility/context (e.g. context-aware blocks) per instance.
- Let site builders expose only a safe subset of blocks to non-technical editors.
- Compose a decoupled-friendly content model where blocks are structured field data.
- Add a "promoted content" block that editors tweak per section landing page.
- Write a custom `BlockFieldSelection` plugin to filter blocks by custom logic.
- Programmatically read the configured block instance from a node in custom code.
- Migrate ad-hoc region blocks into per-content, editorially controlled blocks.
- Reuse the same block plugin with different settings on many different nodes.
- Prototype page layouts quickly without enabling Layout Builder.
