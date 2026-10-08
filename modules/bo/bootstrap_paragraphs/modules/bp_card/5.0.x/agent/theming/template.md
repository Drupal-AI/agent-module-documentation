<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the card

## Theme hook & library

`bp_card.module` → `hook_theme()`: `'paragraph__bp_card' => ['base hook' => 'paragraph']`.
Template: `templates/paragraph--bp-card.html.twig` (override by copying into your theme).

```yaml
# bp_card.libraries.yml
bp-card:
  css:
    component:
      css/bp-card.min.css: { preprocess: false, minified: true }
```

Sources: `scss/bp-card.scss` → `css/bp-card.css` / `.min.css`. The template attaches **only**
`bp_card/bp-card` (unlike the callout template it does *not* attach the parent's
`bootstrap_paragraphs/bootstrap-paragraphs` library).

## Two mutually exclusive layout branches

The whole template is guarded by `{% if card_style == 'card--large-top' %}` and
`{% if card_style == 'card--small-left' %}`. **If `bp_card_style` is empty, nothing renders.**

### Shared wrapper classes

```
paragraph
paragraph--type--bp-card
paragraph--view-mode--{view_mode}
card
{{ bp_margin value }}          e.g. "mt-3 mb-3"
{{ bp_padding value }}         e.g. "pt-3 pb-3"
{{ card_style }}               card--large-top | card--small-left
```

`id="card-{{ paragraph.id.value }}"`.

Margin/padding are pulled straight from `content.bp_margin[0]['#markup']` (the view display
uses a formatter that renders the raw key), so the stored value lands verbatim in `class`.

### `card--large-top`

```html
<div class="… card card--large-top" id="card-12">
  <div class="card-image card-img-top">{{ bp_card_image }}</div>   {# if image #}
  <div class="card-body">
    <h2 class="card-title">…</h2>                                   {# if title #}
    <div class="card-text">…</div>                                  {# if text #}
    {{ content|without(all nine fields) }}
  </div>
  <div class="card-footer">                                         {# if link #}
    <a href="…" class="card-link[ stretched-link][ btn btn-*]">…</a>
  </div>
</div>
```

### `card--small-left`

Same content, wrapped in `<div class="row g-0">` with the image in `col-md-4` and the body
(plus footer) in `col-md-8`.

## The link anchor

```twig
<a href="{{ content.bp_card_link[0]['#url'] }}"
   class="card-link{% if content.bp_link_entire_card[0]['#markup'] == 'On' %} stretched-link{% endif %}{% if content.bp_card_button_style is not empty %} {{ content.bp_card_button_style[0]['#markup'] }}{% endif %}">
```

Two things worth knowing:

- `stretched-link` is added by comparing the **rendered boolean formatter output to the
  literal string `'On'`**. If you change the boolean field's formatter settings (custom
  on/off labels) the stretched-link stops working.
- The button classes come from `content.bp_card_button_style[0]['#markup']`, i.e. the raw
  stored value such as `btn btn-primary`.

## Overriding styles from a theme

```yaml
# mytheme.info.yml
libraries-override:
  bp_card/bp-card:
    css:
      component:
        css/bp-card.min.css: css/my-card.css
```
