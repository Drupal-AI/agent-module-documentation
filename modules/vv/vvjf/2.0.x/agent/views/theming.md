# Theming — templates, preprocess, CSS classes, custom properties

## Theme hooks & templates

Declared in `Drupal\vvjf\Hook\VvjfThemeHook` (`#[Hook('theme')]`). Names are **LOCKED** for v1 theme
overrides.

| Theme hook | Template | Role |
|---|---|---|
| `views_view_vvjf` | `templates/views-view-vvjf.html.twig` | Outer `<vvjf-flipbox>` wrapper + per-row cards (front/back faces). |
| `views_view_vvjf_fields` | `templates/views-view-vvjf-fields.html.twig` | Per-row fields; emits the front/back separator. |

### The split contract

The row template (`views-view-vvjf-fields.html.twig`) outputs the **first field**, then a literal
`<div class="vvjf-separator"></div>`, then the **remaining fields**. The wrapper template does
`row.content|render|split('<div class="vvjf-separator"></div>')` → `front_content` (index 0) and
`back_content` (index 1, `|default('')`). So **front = first field, back = everything after it**. Content
is printed through the `safe_html` Twig filter (from `vvj_core`), which marks the already Views-rendered
field HTML safe.

If you override `views-view-vvjf-fields.html.twig`, keep **exactly one** `vvjf-separator` marker. In v2 the
row template emits it automatically after the first field — unlike v1, you do **not** add a separator
Custom/Text field of your own (a second marker would make `split` keep only the content between the first
two markers and drop the rest). The README's "place a separator field between front and back" step
reflects the v1 workflow.

## Preprocess behaviour — `Hook\VvjfPreprocessHooks`

- **`preprocess_views_view_vvjf`** — only acts when `view.style_plugin` is the `Flipbox` style; flattens the
  style options onto `variables['options']` (the template reads `options.*` directly for its inline CSS
  variables and data attributes), rewrites per-row `#theme` suggestions from `views_view_fields` →
  `views_view_vvjf_fields` so per-row Twig overrides land on the VVJF-namespaced hook, then delegates to
  core's `ViewsThemeHooks::preprocessViewsViewUnformatted()`.
- **`preprocess_views_view_vvjf_fields`** — delegates straight to core's
  `ViewsThemeHooks::preprocessViewsViewFields()` (standard Views field preprocessing). Unlike the accordion,
  it does **not** strip anchors from the first field.
- **`preprocess_views_view`** — adds the legacy `vvj-flipbox` class to the outer view wrapper (v1 parity),
  again only when the style plugin is `Flipbox`.

## Markup & CSS hooks

Outer element (from `views-view-vvjf.html.twig`):
`<vvjf-flipbox id="vvjf-<unique_id>" class="vvjf br-<breakpoint> <flip_trigger> <flip_direction>"
data-flip-trigger="<trigger>" data-breakpoints="<breakpoint>" role="region"
aria-labelledby="vvjf-<unique_id>-label" tabindex="0">`. It contains a visually-hidden `<h2>` label, then
`.flipbox-inner`. Each row is:

```
.flipbox-inner                         ← --box-width, --grid-gap (only when > 0)
  .flipbox-item.<direction>            ← --box-height, --box-perspective (when perspective > 0)
    .flipbox-item-inner                ← inline transition: transform <speed>s <easing>;  JS toggles .flipped
      .flipbox-front.<direction>       ← --bg-color-front; role=group; aria-hidden/tabindex JS-managed
      .flipbox-back.<direction>        ← --bg-color-back;  role=group; aria-hidden/tabindex JS-managed
```

`<direction>` is `horizontal` or `vertical`. The JS toggles **`.flipped`** on `.flipbox-item-inner` to turn
the card; ARIA and `tabindex` on the two faces track that state (see [../api/javascript.md](../api/javascript.md)).

CSS custom properties are set **inline** by the template — override them in your theme instead of fighting
selectors:

- `--box-width` ← `box_width`px (on `.flipbox-inner`, only when > 0)
- `--grid-gap` ← `grid_gap`px (on `.flipbox-inner`, only when > 0)
- `--box-height` ← `box_height` (on `.flipbox-item`; `auto` when 0)
- `--box-perspective` ← `perspective` (on `.flipbox-item`, only when > 0)
- `--bg-color-front` ← `front_bg_color` (on `.flipbox-front`)
- `--bg-color-back` ← `back_bg_color` (on `.flipbox-back`)

## Libraries

- `vvjf/vvjf` — always attached; JS (`vvjf-flipbox-element.js` + `vvjf.js` shim) + `css/vvjf.css`; depends on
  `core/drupal(.ajax)`, `core/drupalSettings`, `core/once`, and `vvj_core/tokens|base|a11y|element-base`.
- `vvjf/vvjf-style` — attached only when **Enable CSS Library** (`enable_css`) is on; `css/vvjf-style.css`.
  Its checkbox description reads "…for styling the tabs" (a copy-paste label artifact; it styles the flipbox).
- `vvjf/vvjf__<breakpoint>` — one of `__all|__576|__768|__992|__1200|__1400`, chosen from
  `available_breakpoints` and appended by `Flipbox::buildLibraryList()`; each is a small media-query CSS file
  (`css/vvjf-<n>.css`) that gates the flip below/above that width.

Uncheck **Enable CSS Library** to drop `vvjf-style` and theme the flipbox from scratch; the structural
`css/vvjf.css` and the breakpoint file still load. No external/CDN CSS is used.

## hook_help

`Hook\VvjfHelpHook` renders `README.md` on route `help.page.vvjf` — via the `markdown` filter plugin when
the `markdown` module is enabled, otherwise an `Html::escape()`-ed `<pre>` block. The path is fixed to the
module's own `README.md`; no user input reaches the file read.
