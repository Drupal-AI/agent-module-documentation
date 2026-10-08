# How the title is suppressed (theming)

The module never deletes the stored title; it removes/hides it at render time through core
preprocess hooks (implemented in `src/Hook/ExcludeNodeTitleHooks.php`, dispatched via the
`#[Hook]` attribute). Whether a title is hidden for a given node + view mode is decided by
`ExcludeNodeTitleManager::isTitleExcluded($node, $view_mode)`.

## Preprocess hooks that hide the title

| Hook | What it does |
|---|---|
| `preprocess_page_title` / `preprocess_page` | On `entity.node.canonical` calls `preprocessTitle($vars, $node, 'full')`; on the node edit form uses the `nodeform` mode; on `entity.node.preview` applies the per-node flag then hides. |
| `preprocess_node` | Applies `preprocessTitle($vars, $node, $view_mode)` for the node being rendered (teaser, full, custom view modes, etc.). |
| `preprocess_html` | On the canonical route removes `head_title['title']` (the `<title>` tag) when excluded and adds a `exclude-node-title` class to the `<body>`; on the edit form relabels the page title to "Edit <type>". |
| `preprocess_field` / `preprocess_search_result` | When the `search` setting is on, blanks the title in `node_search` results / the `title` field in `search_result` view mode. |
| `block_view_page_title_block_alter` | Sets `#access = FALSE` on the core Page Title block (`page_title_block`) for a per-node-excluded node. |

## Render type (`type` setting) — two suppression strategies

`preprocessTitle()` acts differently based on the render type:

- **`remove`** (default) — empties the title markup: sets `$vars['title']`, `$vars['page']['#title']`,
  `$vars['elements']['#title']` to an empty `HtmlEscapedText`, and unsets `$vars['label']`. The HTML
  wrapper tag may remain but the text is gone.
- **`hidden`** — keeps the markup and appends a `visually-hidden` class to `title_attributes`,
  `$vars['page']['#attributes']`, `$vars['elements']['#attributes']`, `$vars['label']['#attributes']`.
  Better for accessibility / SEO (still in the DOM, hidden visually).

(The admin form labels these "Remove text" and "Hidden class"; the "Hidden class" description mentions a
`.hidden` class, but the code applies `visually-hidden`.)

## Assets & Display Suite

- Library `exclude_node_title/drupal.exclude_node_title.admin` (js + `css/exclude_node_title.css`) is
  attached only to the **admin settings form** (fixes fieldset legend positioning); it does not affect
  front-end rendering.
- `hook_ds_fields_info_alter` swaps the Display Suite `node_title` field class for
  `Plugin/DsField/Node/NodeTitle`, which returns empty markup when `isTitleExcluded()` is true, so
  DS-built layouts honor the same settings. A "Use Exclude Node Title" select (default yes) on the DS
  field lets you opt a given display out.

No Twig templates are shipped; the module works with whatever node/page templates the active theme
provides by manipulating the preprocess variables above.

