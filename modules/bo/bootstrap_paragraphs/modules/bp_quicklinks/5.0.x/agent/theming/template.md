<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the Quicklinks bundle

## Theme hook

`bp_quicklinks.module` implements only `hook_theme()` (plus a README-printing
`hook_help()`):

```php
'paragraph__bp_quicklinks' => ['base hook' => 'paragraph']
```

so the suggestion `paragraph--bp-quicklinks.html.twig` is honoured for **every** view mode.
Override it by copying `templates/paragraph--bp-quicklinks.html.twig` into your theme (add
`--default` / `--<view-mode>` if you need per-view-mode variants).

## Library

`bp_quicklinks.libraries.yml`:

```yaml
bp-quicklinks:
  css:
    component:
      css/bp-quicklinks.min.css: { preprocess: false, minified: true }
```

The template attaches **two** libraries itself — `bootstrap_paragraphs/bootstrap-paragraphs`
(the parent's shared width/background CSS) and `bp_quicklinks/bp-quicklinks`. Source SCSS is
`scss/bp-quicklinks.scss`; the unminified build is `css/bp-quicklinks.css`.

## Markup the template emits

```html
<div class="paragraph paragraph--type--bp-quicklinks paragraph--view-mode--default
            {WIDTH CLASSES} {BACKGROUND CLASSES}">
  <div class="paragraph__column">
    <h2>{{ bp_header }}</h2>              {# only when bp_header is not empty #}
    <ul class="quicklinks quicklinks-{{ paragraph.id }}">
      <li class="quicklink quicklink-1"> … link 1 … </li>
      <li class="quicklink quicklink-2"> … link 2 … </li>
    </ul>
  </div>
</div>
```

- The `<ul>` carries a per-paragraph id class built as `'quicklinks-' ~ paragraph.id.value`
  — a stable hook for targeting one specific block.
- `<li>` indices are 1-based (`key + 1` over the filtered render array).
- The width/background classes are **the stored field values verbatim**: `bp_width` yields
  one of `paragraph--width--{tiny,narrow,medium,wide,full}`; `bp_background` yields e.g.
  `paragraph--color paragraph--color--primary`. The template whitelists each value with a
  long ternary list, so a value that is not in that whitelist emits no class.

## CSS the module ships (`css/bp-quicklinks.css`)

```css
.quicklinks       { display:flex; flex-wrap:wrap; justify-content:space-around;
                    align-items:stretch; list-style:none; margin:0; padding:0; }
.quicklinks .quicklink   { margin-bottom:1rem; padding:3rem 2rem; }
.quicklinks .quicklink a { background:#f8f9fa; padding:3rem 2rem;
                           transition:all .25s ease-in-out; }
.quicklinks .quicklink a:hover { background:#6c757d; transition:all .25s ease-in-out; }
```

A flex row of equal-height tiles with a light-grey link background that darkens on hover.
Restyle by overriding `.quicklinks`/`.quicklink` in your theme, or drop the library
entirely with `hook_library_info_alter()` / a theme-level `libraries-override`.

## Gotcha

Because the template loops `content.bp_quick_link` itself, the view-display formatter
settings for that field (trim length, `rel`, `target`) still apply to each rendered item,
but the surrounding `<ul>`/`<li>` structure is fixed by the template — changing the
formatter will not change the list markup.
