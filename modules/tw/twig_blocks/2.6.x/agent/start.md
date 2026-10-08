# Twig Blocks — agent index

Adds a `render_block()` Twig function to render a placed block by ID from a template, plus a
`twig_blocks.block_view_builder` service that renders a block *plugin* by ID. No config UI
(`configure` null), no permissions, no schema, no Drush, no dependencies beyond core.

- **`render_block()` Twig function, its arguments, the config-save side effect, and the
  `BlockViewBuilder` service** → [theming/render-block.md](theming/render-block.md)

Key facts:
- Twig extension: `src/Twig/RenderBlock.php` (service `twig_blocks.twig.render_block`,
  tag `twig.extension`). Function `render_block(block_id, configuration = {})`, `is_safe: html`.
- `render_block()` loads the **config Block entity** by ID; passing `configuration` merges into the
  entity's `settings` and **saves** it before rendering.
- Service `twig_blocks.block_view_builder` (`src/View/BlockViewBuilder.php`) builds from a **block
  plugin ID**, runs `access()`, injects contexts, applies `#theme => block`, adds cacheability.
