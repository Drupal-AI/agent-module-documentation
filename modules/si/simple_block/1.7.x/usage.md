<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Block provides title/content custom blocks stored as **config entities** (not content), so they can be exported with configuration management and deployed across environments.

---

Unlike core's *Block Content* (`block_content`), which stores blocks as content entities in the database, Simple Block stores each block as a `simple_block` **config entity** holding just an `id` (machine name), a `title`, and a formatted-text `content` (a `text_format` value + filter format). This makes blocks part of your exported config (config sync YAML) rather than site content — ideal when a block's markup should be deployed like code. Blocks are managed at `/admin/structure/block/simple-block` (route `entity.simple_block.collection`; add/edit/clone/delete forms) and rendered by a block plugin, `simple_block`, **derived per entity** as `simple_block:<id>`; the plugin outputs `#type => processed_text` with the block's format and **global token** replacement. A field formatter, `simple_block_rendered_entity`, renders a referenced simple block from an `entity_reference` field. Three permissions gate editing (`update simple blocks`), cloning (`clone simple blocks`), and deleting (`delete simple blocks`); adding and listing require core's `administer blocks`. The optional **Simple Block + Layout Builder** submodule lets you create/edit these blocks directly in the Layout Builder UI. Depends on `block` and `filter`.

---

- Store a reusable promo/notice block as config so it deploys with your codebase.
- Manage marketing copy blocks through config sync instead of content.
- Ship the same footer/disclaimer block identically to dev, stage, and prod.
- Create title + rich-text blocks at `/admin/structure/block/simple-block`.
- Place a simple block in a region using the `simple_block:<id>` block plugin.
- Use global tokens inside a block's content (rendered via `token->replace`).
- Clone an existing simple block to create a variant quickly.
- Render a referenced simple block through the `simple_block_rendered_entity` formatter.
- Reference simple blocks from an entity_reference field on nodes/paragraphs.
- Keep block markup under version control alongside the rest of the site config.
- Grant editors `update simple blocks` without giving full block administration.
- Restrict who can delete or clone blocks via the dedicated permissions.
- Build blocks in the Layout Builder UI with the layout-builder submodule.
- Provide a lightweight alternative to block_content when history/revisions aren't needed.
- Export a set of standard blocks as a config recipe for new sites.
- Apply a specific text format (e.g. Full HTML) to a block's content.
- Use cache tags so blocks invalidate correctly when the entity or format changes.
- Create environment-specific blocks by overriding config in settings.
- Maintain a library of small content snippets as configuration.
- Place the same simple block in multiple regions/themes by id.
- Migrate hard-coded template markup into editable, deployable config blocks.
- Give a CTA block a token-driven dynamic value (e.g. site name).
