Example Blocks is a learning/reference submodule of Gutenberg that demonstrates how to add custom editor blocks: a client-side "Card" block and a server-rendered "Dynamic Card" block, wired up through an `example_blocks.gutenberg.yml` discovery file and a JS library.

---

The submodule ships no PHP, config, or permissions — it is a worked example of Gutenberg's block-extension pattern. Its `example_blocks.gutenberg.yml` registers a JS library on both the editor and the front end (`libraries-edit` / `libraries-view` = `example_blocks/blocks`), declares one server-rendered block under `dynamic-blocks` (`example-blocks/dynamic-card`), and adds two blocks to the editor's "Media" category under `custom-blocks` (`example-blocks/card` and `example-blocks/dynamic-card`). The `example_blocks/blocks` asset library (`example_blocks.libraries.yml`) loads compiled `dist/blocks.js` + `dist/style-blocks.css` and depends on Gutenberg's `gutenberg/react`, `gutenberg/block-editor`, `gutenberg/blocks`, and `gutenberg/components` libraries. In JS, `blocks/index.js` calls `registerBlockType('example-blocks/card', …)` and `registerBlockType('example-blocks/dynamic-card', …)`; each block has a `block.json` (attributes, supports, styles, variations). The **Card** block saves its own HTML client-side (it has a `save.js`), while the **Dynamic Card** block is server-rendered from the Twig template `templates/gutenberg-block--example-blocks--dynamic-card.html.twig`, which prints `block_attributes.imageUrl`, `title`, `subhead`, and `block_content`. Enable the submodule to make the blocks available in the Gutenberg editor; it is intended as a starting point to copy into your own module.

---

- Learn how to register custom Gutenberg blocks in a Drupal module.
- Copy the `example_blocks.gutenberg.yml` structure as a template for your own blocks.
- See how to declare `libraries-edit` / `libraries-view` for editor and front-end assets.
- Study a client-side (static/save.js) block: the "Card" block.
- Study a server-rendered (dynamic) block: the "Dynamic Card" block with a Twig template.
- See how `dynamic-blocks` maps a block id to a `gutenberg-block--<module>--<block>.html.twig` template.
- See how `custom-blocks` adds blocks into an editor category (here "Media").
- Reference a real `block.json` (attributes, supports, styles, variations) for a Gutenberg block.
- See how blocks depend on the `gutenberg/react`/`block-editor`/`blocks`/`components` libraries.
- Understand how `registerBlockType()` is used from a module's compiled JS bundle.
- Provide a "Card" UI block (image, title, subhead) for content editors as a demo.
- Provide a "Pet Card" variation via block.json `variations`.
- Demonstrate block `styles` (Default / Right aligned image) selectable in the editor.
- Use as a smoke test that a site's Gutenberg block build pipeline works.
- Prototype a bespoke content block by adapting the Card example.
- Show how server-side block attributes are exposed to Twig (`block_attributes`).
- Teach the difference between static (client-saved) and dynamic (server-rendered) blocks.
- Bootstrap a webpack build for Gutenberg blocks (ships `webpack.config.js`).
- Verify Gutenberg's custom-block discovery is working by enabling this module.
- Serve as documentation-by-example alongside `gutenberg.api.php`.
