# Example Blocks — agent index

Learning submodule of **gutenberg**. A worked example of adding custom Gutenberg editor blocks: a
client-side **Card** block and a server-rendered **Dynamic Card** block, registered via an
`example_blocks.gutenberg.yml` discovery file and a JS library. No PHP, config, permissions, or
Drush — copy it as a template.

- **The discovery file, blocks, libraries, and static-vs-dynamic pattern** →
  [plugins/example-blocks.md](plugins/example-blocks.md)

Parent module → `modules/gutenberg/3.0.x/` (see its
`agent/plugins/blocks-and-plugins.md` for the general extension mechanics).

Key facts:
- `example_blocks.gutenberg.yml`: `libraries-edit`/`libraries-view` = `example_blocks/blocks`;
  `dynamic-blocks` = `example-blocks/dynamic-card`; `custom-blocks` adds `example-blocks/card`
  and `example-blocks/dynamic-card` to the "Media" category.
- Asset library `example_blocks/blocks` (`dist/blocks.js`, `dist/style-blocks.css`) depends on
  `gutenberg/react`, `gutenberg/block-editor`, `gutenberg/blocks`, `gutenberg/components`.
- JS: `blocks/index.js` → `registerBlockType('example-blocks/card', …)` and `…/dynamic-card`.
- Card = client-side (`save.js`); Dynamic Card = server-rendered via
  `templates/gutenberg-block--example-blocks--dynamic-card.html.twig`.
- Each block has a `block.json` (attributes, supports, styles, variations).
