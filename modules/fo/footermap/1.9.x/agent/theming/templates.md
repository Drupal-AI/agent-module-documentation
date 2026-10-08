# Theming Footermap

Three theme hooks (declared in `footermap_theme()`), each with a Twig template in
`templates/` and a preprocess in `footermap.theme.inc`.

| Theme hook | Template | Variables |
|---|---|---|
| `footermap` | `footermap.html.twig` | `footermap` (the rendered map), `title`, `block`, `attributes` |
| `footermap_header` | `footermap-header.html.twig` | `title` (menu label), `title_display`, `items`, `menu_name`, `attributes`, `title_attributes` |
| `footermap_item` | `footermap-item.html.twig` | `title`, `url` (Url object), `level`, `children`, `weight`, `attributes`, `link_attributes`, `has_children` |

## Render structure

`FootermapBlock::build()` returns `#theme => 'footermap'` with `#footermap` set to a nested
render array. `buildMap()` creates one `footermap_header` element per selected menu, and
`buildMenu()` recursively fills each with `footermap_item` elements (`#children` holds the
subtree). The block attaches the `footermap/footermap` library (`css/footermap.css`).

## Preprocess behavior (`footermap.theme.inc`)

- `template_preprocess_footermap`: wraps `attributes` in an `Attribute` object.
- `template_preprocess_footermap_item`: builds `link_attributes` from the Url's options, sets
  `has_children`, and sorts `children` by the `weight` property
  (`SortArray::sortByWeightProperty`).
- `template_preprocess_footermap_header`: adds heading classes (`footermap-col-heading`,
  `footermap-col-heading--<menu_name>`), appends `visually-hidden` when the heading is hidden,
  and sorts `items` by weight.

## CSS classes (BEM-style)

- Wrapper: `footermap`, `footermap--footermap_block`.
- Column heading: `footermap-header`, `footermap-header--<menu_name>`.
- Item: `footermap-item`, `footermap-item--depth-<n>`, and `footermap-item--haschildren` when it
  has children.

## Customizing

Override any of the three templates in your theme (copy from `templates/` and adjust markup), or
implement `hook_preprocess_footermap_item()` etc. to alter variables. To restyle only, override
`css/footermap.css` via the `footermap/footermap` library or your theme's CSS. There are no theme
settings and no theme functions beyond these hooks.
