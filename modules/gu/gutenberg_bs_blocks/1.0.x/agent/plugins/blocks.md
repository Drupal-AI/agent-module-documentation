# The three Gutenberg blocks (bootstrap/container, row, column)

All three are **static** Gutenberg blocks registered in the browser with `wp.blocks.registerBlockType`
(there is no PHP block plugin and no server-side render). Each block's `save` component builds a Bootstrap
class string with the `classnames` helper and returns `<div className=…><InnerBlocks.Content/></div>`; that
markup is what Gutenberg writes into the node body and what the front-end serves. Source lives under
`libraries/js/<block>/` and is compiled to `build/js/<block>.js`.

The shared **category** is registered in `libraries/js/category.es6.js`: slug `bootstrap`, title "Bootstrap",
pushed onto the front of `core/blocks` categories via `wp.data.dispatch("core/blocks").setCategories`.

## `bootstrap/container`

- Registered in `libraries/js/container/index.es6.js`. Title "Container", icon `layout`.
- Attributes (`container/config/attributes.es6.js`): `align` — string, default `"wide"`.
- Supports (`container/config/supports.es6.js`): `align: ["wide","full"]`, `anchor: true`, `html: false`,
  `className: false`.
- `save` (`container/components/BlockSave.es6.js`): class is `container` when `align === "wide"`,
  `container-fluid` when `align` is empty or `"full"`, plus the incoming `className`. Output:
  `<div class="container|container-fluid …"><InnerBlocks.Content/></div>`.
- Transforms (`container/config/transforms.es6.js`): `from` a `core/group` block, and a multi-block
  `__experimentalConvert` that groups any selected blocks into a `bootstrap/container` (picking the widest
  `align` — `wide`/`full` — of the grouped blocks). Single `core/group`/`bootstrap/container` selections are skipped.

## `bootstrap/row`

- Registered in `libraries/js/row/index.es6.js`. Title "Row", icon `grid-view`.
- Attributes (`row/config/attributes.es6.js`): `horizontalAlignment` (string), `verticalAlignment` (string).
- Supports (`row/config/supports.es6.js`): `html: false`, `className: false` (no `align`, no `anchor`).
- `getEditWrapperProps` (`row/config/getEditWrapperProps.es6.js`): adds editor-only
  `data-horizontal-alignment` / `data-vertical-alignment` attributes (drives edit-mode CSS, not saved output).
- `save` (`row/components/BlockSave.es6.js`): base class `row`, plus `justify-content-{start|center|end}`
  from `horizontalAlignment` (`left`/`center`/`right`) and `align-items-{start|center|end}` from
  `verticalAlignment` (`top`/`center`/`bottom`).
- Variations (`row/config/variations.es6.js`, `scope: ["block"]`, shown as a block variation picker):
  `two-columns-equal` (50/50, `isDefault`), `two-columns-one-third-two-thirds` (30/70, columns `sizeMd` 4/8),
  `two-columns-two-thirds-one-third` (70/30, `sizeMd` 8/4), `three-columns-equal` (33/33/33),
  `three-columns-wider-center` (25/50/25, `sizeMd` 3/6/3). Each variation's `innerBlocks` are `bootstrap/column`s.

## `bootstrap/column`

- Registered in `libraries/js/column/index.es6.js`. Title "Column", icon `columns`,
  `parent: ["bootstrap/row"]` (only insertable inside a row).
- Attributes (`column/config/attributes.es6.js`): `alignment` (string) and the numeric responsive set
  `size{Xs,Sm,Md,Lg,Xl}`, `order{Xs,Sm,Md,Lg,Xl}`, `offset{Xs,Sm,Md,Lg,Xl}`.
- Supports (`column/config/supports.es6.js`): `anchor: true`, `html: false`, `className: false`, `reusable: false`.
- Breakpoint infixes come from `libraries/js/breakpoints.es6.js` (`["Xs","Sm","Md","Lg","Xl"]`; `getInfix`
  returns `""` for Xs else `-sm`/`-md`/`-lg`/`-xl`).
- `save` (`column/components/BlockSave.es6.js`) emits Bootstrap column classes:
  `col`/`col-{infix}` and `col{infix}-{size}` from `size*`; `order{infix}-first` (order `-1`),
  `order{infix}-last` (order `13`), else `order{infix}-{order}`; `offset{infix}-{offset}` for `offset > 0`;
  and `align-self-{start|center|end}` from `alignment` (`top`/`center`/`bottom`). Bare `col` when no size set.
- `getEditWrapperProps` mirrors these into `data-size*` / `data-order*` / `data-offset*` / `data-alignment`
  attributes for the edit canvas.

## Notes for an agent

- To add a fourth block you edit the JS (`registerBlockType(category.slug + "/<name>", …)`), add a library +
  wire it in `gutenberg_bs_blocks.gutenberg.yml`, and rebuild `build/` — see [../api/integration.md](../api/integration.md).
- Because `supports.html = false`, editors cannot switch these blocks to raw-HTML editing; because
  `className = false`, the core "Additional CSS class" control is hidden. The saved class list is fully
  determined by the typed attributes above (strings/numbers), not by free-form user text.
