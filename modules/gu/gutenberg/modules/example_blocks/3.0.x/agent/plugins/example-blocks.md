# Example Blocks — the block-extension pattern

This submodule is a copyable example of registering Gutenberg blocks. Files that matter:

## `example_blocks.gutenberg.yml` (discovery)

```yaml
libraries-edit:
  - example_blocks/blocks     # JS/CSS attached to the editor
libraries-view:
  - example_blocks/blocks     # JS/CSS attached to the rendered node
dynamic-blocks:
  example-blocks/dynamic-card: {}   # server-rendered via a Twig template
custom-blocks:
  categories:
    - reference: media        # add to the "Media" block category
      name: Media
      blocks:
        - id: example-blocks/card
          name: Card
        - id: example-blocks/dynamic-card
          name: Dynamic Card
```

## `example_blocks.libraries.yml`

```yaml
blocks:
  js:
    dist/blocks.js: {}
  css:
    layout:
      dist/style-blocks.css: { weight: 100 }
  dependencies:
    - gutenberg/react
    - gutenberg/block-editor
    - gutenberg/blocks
    - gutenberg/components
```

## JS registration (`blocks/index.js`)

```js
import { registerBlockType } from "@wordpress/blocks";
import Card from "./card";
import DynamicCard from "./dynamic-card";

registerBlockType("example-blocks/card", Card);
registerBlockType("example-blocks/dynamic-card", DynamicCard);
```

Each block dir has a `block.json` (`apiVersion: 2`, `name`, `title`, `attributes`, `supports`,
`styles`, `variations`) — e.g. `card/block.json` defines `imageUrl`/`title`/`subhead` attributes,
color supports, Default/Right-aligned-image styles, and a "Pet Card" variation.

## Static vs dynamic block

- **`example-blocks/card`** — a *static* block: it has an `edit.js` and `save.js`, so its markup
  is produced client-side and saved into the content.
- **`example-blocks/dynamic-card`** — a *dynamic* block: listed under `dynamic-blocks`, it is
  rendered server-side from `templates/gutenberg-block--example-blocks--dynamic-card.html.twig`.
  Template variables: `block_name`, `block_content`, `block_attributes` (e.g. `imageUrl`,
  `imageAlt`, `title`, `subhead`), `attributes`.

## To use / adapt

Enable the module (`drush en example_blocks`) to expose the blocks in the Gutenberg editor, or
copy this directory into your own module and rename `example-blocks/*` to your namespace. The
build is webpack-based (`webpack.config.js`, `package.json`) producing `dist/blocks.js`. See the
parent module's `agent/plugins/blocks-and-plugins.md` for the full discovery/rendering mechanics.
