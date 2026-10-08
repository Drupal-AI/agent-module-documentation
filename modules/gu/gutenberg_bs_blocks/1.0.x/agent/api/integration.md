# Asset wiring, Gutenberg integration & build (API)

This module has no PHP API surface — no routes, services, controllers, or plugin managers. Its "API" is the
declarative asset wiring that hands compiled JS/CSS to the **Gutenberg** editor and to the front-end node view,
plus the webpack/babel build that produces those bundles.

## `hook_help` (the only PHP)

`gutenberg_bs_blocks.module` implements `gutenberg_bs_blocks_help($route_name, RouteMatchInterface $route_match)`
for route `help.page.gutenberg_bs_blocks` — a static About/Requirements page noting the editor needs the
**Gutenberg Experience** enabled on the content type and the front theme must ship **Bootstrap > 4.5**. No other
hooks are implemented.

## Libraries — `gutenberg_bs_blocks.libraries.yml`

| Library | JS | CSS | Depends on |
|---|---|---|---|
| `bootstrap` | — | `build/css/bootstrap.css` (theme) | — |
| `block-edit` | — | `build/css/block-edit.css` | `gutenberg/edit-node` |
| `block-view` | — | `build/css/block-view.css` | — |
| `container-block-edit` | `build/js/container.js` | `build/css/container-edit.css` | `gutenberg/edit-node` |
| `container-block-view` | — | `build/css/container-view.css` | — |
| `row-block-edit` | `build/js/row.js` | `build/css/row-edit.css` | `gutenberg/edit-node` |
| `column-block-edit` | `build/js/column.js` | `build/css/column-edit.css` | `gutenberg/edit-node` |

Only the three `*-block-edit` libraries carry JS (the `registerBlockType` bundles); view libraries are CSS-only.
The `bootstrap` library loads a full Bootstrap stylesheet **inside the editor** so the editor canvas previews the
grid (the front theme is expected to provide Bootstrap on the real page).

## Gutenberg wiring — `gutenberg_bs_blocks.gutenberg.yml`

The Gutenberg module reads each module's `*.gutenberg.yml` to know which libraries to attach. Here:

```yaml
libraries-edit:            # attached on node edit (the editor)
  - gutenberg_bs_blocks/bootstrap
  - gutenberg_bs_blocks/block-edit
  - gutenberg_bs_blocks/container-block-edit
  - gutenberg_bs_blocks/row-block-edit
  - gutenberg_bs_blocks/column-block-edit
libraries-view:           # attached on the rendered node
  - gutenberg_bs_blocks/block-view
  - gutenberg_bs_blocks/container-block-view
```

Note the view side attaches only CSS for the container/generic wrappers — the block markup itself is the static
HTML saved by each block's `save()` (see [../plugins/blocks.md](../plugins/blocks.md)); nothing in this module
re-renders it server-side.

## Build pipeline

- Source: `libraries/js/**/*.es6.js` (JSX/ES modules) and `libraries/sass/**/*.scss`.
- Config: `webpack.config.js`, `.babelrc`, deps in `package.json` (`@wordpress/*`, `classnames`, babel, sass-loader).
- Output (committed, and what Drupal actually loads): `build/js/{container,row,column}.js`,
  `build/css/*.css`. Rebuild with the project's node toolchain (e.g. `ddev npm ci && ddev npm run build`
  inside the module) after editing anything under `libraries/`; editing `build/` directly is overwritten by a rebuild.

## Adding a block (agent recipe)

1. Create `libraries/js/<name>/index.es6.js` calling
   `registerBlockType(category.slug + "/<name>", { attributes, supports, save, edit, … })`, plus its
   `config/` (attributes/supports) and `components/` (`BlockEdit`, `BlockSave`).
2. Add `<name>-block-edit` (and any `-view`) entries to `gutenberg_bs_blocks.libraries.yml` pointing at the
   new built bundle; declare the `gutenberg/edit-node` dependency for the edit library.
3. Reference the new library from `libraries-edit` / `libraries-view` in `gutenberg_bs_blocks.gutenberg.yml`.
4. Add an entry/rule for the new bundle in `webpack.config.js` and rebuild `build/`.
