<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the Statistics bundles

## Theme hooks

`bp_statistics.module` implements only `hook_theme()` (plus a README-printing
`hook_help()`), registering three suggestions:

```php
'paragraph__bp_stat'             => ['base hook' => 'paragraph'],
'paragraph__bp_statistics'       => ['base hook' => 'paragraph'],
'field__paragraph__bp_statistic' => ['base hook' => 'paragraph'],
```

(the third is a *field* template registered with `base hook: paragraph` — that is what the
module ships; it still resolves because the suggestion name matches
`field--paragraph--bp-statistic.html.twig`.)

## Library

```yaml
bp-statistics:
  css:
    component:
      css/bp-statistics.min.css: { preprocess: false, minified: true }
```

Source is `less/bp-statistics.less`; the unminified build is `css/bp-statistics.css`.
`paragraph--bp-statistics.html.twig` attaches both
`bootstrap_paragraphs/bootstrap-paragraphs` and `bp_statistics/bp-statistics`.

## The three templates

### `paragraph--bp-statistics.html.twig` (outer)

Same shape as every other bp_* container template: it whitelists the stored `bp_width` and
`bp_background` values and merges them verbatim into the wrapper classes, then prints the
header and the `bp_statistic` field inside `.paragraph__column`:

```html
<div class="paragraph paragraph--type--bp-statistics paragraph--view-mode--default
            paragraph--width--wide paragraph--color paragraph--color--info">
  <div class="paragraph__column"> … header + stats … </div>
</div>
```

A `bp_background` value outside the template's whitelist emits no class.

### `field--paragraph--bp-statistic.html.twig` (the column logic)

This is the interesting one — three lines that decide the layout:

```twig
{%- for item in items -%}
  <div class="paragraph--type--bp-statistics__{{ loop.length }}col">
    <div{{ item.attributes }}>{{ item.content }}</div>
  </div>
{%- endfor -%}
```

`loop.length` is the **number of stats in the field**, so every item gets the same class and
the class name encodes the count: 3 stats → `paragraph--type--bp-statistics__3col`, 4 stats →
`…__4col`. There is no manual column setting; add or remove a Stat and the layout changes.

### `paragraph--bp-stat.html.twig` (inner item)

```html
<div class="paragraph paragraph--type--bp-stat paragraph--view-mode--default statistic">
  <div class="statistic-header">{{ content.bp_statistic_header }}</div>
  <div class="statistic-item">{{ content.bp_statistic_item }}</div>
  <div class="statistic-description">{{ content.bp_statistic_description }}</div>
  {{ content|without('bp_statistic_description','bp_statistic_header','bp_statistic_item') }}
</div>
```

Note the extra `statistic` class on the wrapper and the trailing `content|without(...)` so
any field you add to `bp_stat` later still renders.

## CSS the module ships

```css
.paragraph.paragraph--type--bp-statistics > .paragraph__column { padding-left:0; padding-right:0; }
.paragraph.paragraph--type--bp-statistics .paragraph--type--bp-statistics__4col {
  position:relative; min-height:1px; padding:0 15px;
}
@media (min-width:768px) {
  .paragraph.paragraph--type--bp-statistics .paragraph--type--bp-statistics__4col { float:left; width:25%; }
  /* …__3col → 33.33%, …__2col → 50%, …__1col → 100% */
}
```

Float-based Bootstrap-3-style columns that stack below 768px.

## Overriding

- Copy any of the three templates into your theme (optionally adding `--<view-mode>`).
- To change the column maths, override `field--paragraph--bp-statistic.html.twig` — e.g.
  swap `loop.length` for a fixed grid or a CSS-grid wrapper.
- To drop the shipped CSS, use a theme `libraries-override` on
  `bp_statistics/bp-statistics`, or `hook_library_info_alter()`.
