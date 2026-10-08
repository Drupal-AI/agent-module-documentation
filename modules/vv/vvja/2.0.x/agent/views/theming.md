# Theming — templates, preprocess, CSS classes, custom icons

## Theme hooks & templates

Declared in `Drupal\vvja\Hook\VvjaThemeHook` (`#[Hook('theme')]`). Names are **LOCKED** for v1 theme
overrides.

| Theme hook | Template | Role |
|---|---|---|
| `views_view_vvja` | `templates/views-view-vvja.html.twig` | Outer `<vvja-accordion>` wrapper + per-row panels/triggers. |
| `views_view_vvja_fields` | `templates/views-view-vvja-fields.html.twig` | Per-row fields; emits the trigger/pane separator. |

### The split contract

The row template outputs the first field, then a literal `<div class="vvja-separator"></div>`, then the
remaining fields. The wrapper template does `row.content|render|split('<div class="vvja-separator"></div>')`
→ `button_content` (index 0) and `pane_content` (index 1). Keep that marker if you override
`views-view-vvja-fields.html.twig`. Content is output through the `safe_html` Twig filter (from
`vvj_core`), which marks the already Views-rendered field HTML safe.

## Preprocess behaviour — `Hook\VvjaPreprocessHooks`

- **`preprocess_views_view_vvja`** — flattens the style options into template vars, builds a `data-*`
  attribute bag (`list_attributes`: `data-animation`, `data-unique-id`, `data-transition-speed`,
  `data-accordion-item-width`, `data-global-toggle`, `data-single-toggle`, `data-expand-default`,
  `data-enable-css`, `data-exclusive-panel`), exposes `settings`, **re-sanitizes the four custom SVG
  icons via `vvj_core.svg_sanitizer`** (emits `Markup`; strips entirely if the sanitizer is unavailable
  during the upgrade window), and rewrites per-row `#theme` suggestions from `views_view_fields` →
  `views_view_vvja_fields` so per-row Twig overrides land on the VVJA-namespaced hook. Finally delegates
  to core's `ViewsThemeHooks::preprocessViewsViewUnformatted()`.
- **`preprocess_views_view_vvja_fields`** — after core field preprocess, **strips `<a>…</a>` from the
  first field's rendered content** (`stripAnchorTags()`, regex `#</?a(\s[^>]*)?>#i`, re-marked as
  `Markup`). Rationale: the trigger is a `<button>`/`<a>`, and a nested clickable `<a>` is invalid /
  misleading. Only the first (trigger) field is affected; pane fields keep their links.
- **`preprocess_views_view`** — adds the legacy `vvj-accordion` class to the outer view wrapper (v1
  parity; `vvj_core` separately adds `.vvj-component` and `.vvj-vvja`).

## CSS hooks

Outer element `<vvja-accordion class="vvja vvja-<unique_id> …">`. Conditional classes: `global-toggle-on`,
`single-toggle-on`, `expand-first` / `expand-all`, `max-w` (when `accordion_item_width` > 0). Inner
structure: `.vvja-inner`, `.global-toggle`, `.vvja-item.opened|.closed`, `.vvja-button`, `.vvja-pane`
(+ the animation class, e.g. `a-fade`), `.vvja-pane-inner`.

CSS custom properties set inline on `.vvja-inner` / `.vvja-pane`, override them in your theme instead of
fighting selectors:
- `--vvja-grid-gap` ← `panel_gap`px
- `--vvja-pane-padding` ← `pane_padding`px
- `--vvja-box-width` ← `accordion_item_width` (only when > 0)
- `--vvja-transition-speed` ← `transition_speed`s

Libraries: `vvja/vvja` (always, JS+`css/vvja.css`), `vvja/vvja-style` (only when `enable_css`,
`css/vvja-style.css`), `vvja/vvja-admin` (Views-UI form only). Uncheck **Enable CSS Library** to drop
`vvja-style` and theme from scratch.

## Custom SVG icons & sanitization

The four `svg_*` options let an admin paste raw SVG for the panel and global toggle icons; empty falls
back to the bundled icons under `svg/` (`expand-content.svg`, `collapse-content.svg`, `expand-all.svg`,
`collapse-all.svg`). Input is sanitized twice by `vvj_core`'s `SvgSanitizer`: at save
(`Accordion::validateSvgField`) and again at render (`preprocessViewsViewVvja`). The sanitizer requires
a well-formed `<svg>` root, whitelists a fixed element + attribute set, blocks `<script>`/`<foreignObject>`
/`<iframe>`/`<object>`/`<embed>`, strips all `on*` handlers, drops `javascript:`/`data:`/`vbscript:` URIs,
and permits only same-document `#fragment` `href`/`xlink:href` values. Use `fill="currentColor"` so icons
inherit theme colour.

## hook_help

`Hook\VvjaHelpHook` renders `README.md` on route `help.page.vvja` (via the `markdown` filter plugin when
the `markdown` module is enabled, else an escaped `<pre>` block).
