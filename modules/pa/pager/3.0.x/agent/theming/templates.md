<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Themes, templates & CSS

`pager_theme()` (in `pager.module`) registers two theme hooks, each with a single `data` variable
(an array of nav objects built by the block):

| Theme hook   | Template                          | Look |
|--------------|-----------------------------------|------|
| `pager_block`| `templates/pager--block.html.twig`| Centred wrapper (`.pager-block-wrapper`), up to two items side by side, ~520px wide, thumbnail + title + `« label »`. |
| `pager_wings`| `templates/pager--wings.html.twig`| Fixed slide-out side tabs (`position: fixed; top: 50vh`), prev tab on the left, next on the right; the panel expands on hover via a CSS width transition. |

The block form's Theme select lists these by template filename; `build()` sets `#theme` to the
chosen hook and falls back to `pager_block` if unset.

## Nav object fields consumed by the templates
Each `data` entry is a stdClass with: `href`, `src`, `alt`, `title`, `label`, `class`
(`pager-prev-node` / `pager-next-node`), `width`, `height`.

## CSS library
`pager.libraries.yml` defines `drupal.pager-links` → `css/pager.css` (component CSS), attached by the
block build. It styles both the centred block and the "wings" side tabs (hover width transitions,
`«`/`»` prefix/suffix glyphs, per-side alignment).

## Escaping note (for template overrides)
Values are escaped in PHP before reaching Twig: `title` and `label` are `Html::escape()`d in
`getNavItem()`, `alt` is regex-scrubbed by `filterAlt()`, `href` comes from `Url::toString()`, and
`src` is an image-style URL. The stock templates print `href`, `src` and `title` with the `|raw`
filter — safe here only because those values are pre-escaped/generated. If you override a template,
keep printing those fields with values that are already safe (or drop `|raw` and let Twig
autoescape); do not feed unescaped user input through `|raw`.
