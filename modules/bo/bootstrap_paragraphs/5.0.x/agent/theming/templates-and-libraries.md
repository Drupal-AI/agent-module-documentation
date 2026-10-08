<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates, theme hooks and asset libraries

`bootstrap_paragraphs.module` is 93 lines and contains exactly three hooks. Everything visual
is Twig + CSS.

## The three hooks

1. **`hook_theme()`** — registers template hooks, each with `'base hook' => 'paragraph'`:
   `paragraph__default`, `paragraph__bp_accordion`, `paragraph__bp_carousel`,
   `paragraph__bp_tabs`, `paragraph__bp_columns`, `paragraph__bp_columns_three_uneven`,
   `paragraph__bp_columns_two_uneven`, `paragraph__bp_image`, `paragraph__bp_modal`,
   `field__entity_reference_revisions`, `field__paragraph__bp_column_content`,
   `field__paragraph__bp_column_content_2`, `field__paragraph__bp_column_content_3`,
   `field__paragraph__bp_image__image`.
   Note `paragraph__default` — it becomes the fallback for **every** bp_* bundle that has no
   template of its own (Simple, Blank, Block, View, and the submodule bundles).

2. **`hook_help()`** — prints `README.md` on `/admin/help/bootstrap_paragraphs`.

3. **`hook_preprocess_paragraph()`** — the only real logic:

   ```php
   if ($p->hasField('bp_background') && !$p->get('bp_background')->isEmpty()) {
     $variables['bs']['background_color'] =
       str_replace('paragraph--color paragraph--color--', 'bg-', $p->get('bp_background')->getString());
   }
   ```

   So a stored `paragraph--color paragraph--color--primary` becomes the Bootstrap 5 utility
   class `bg-primary`, available in Twig as **`bs.background_color`**. (`paragraph--color--transparent`
   has no `paragraph--color--` prefix pair, so it passes through unchanged.)

## Template files (`templates/`)

```
paragraph--default.html.twig                     ← fallback for all bundles
paragraph--bp-accordion.html.twig
paragraph--bp-carousel.html.twig
paragraph--bp-columns.html.twig
paragraph--bp-columns-two-uneven.html.twig
paragraph--bp-columns-three-uneven.html.twig
paragraph--bp-image.html.twig
paragraph--bp-modal.html.twig
paragraph--bp-tabs.html.twig
field--entity-reference-revisions.html.twig
field--paragraph--bp-column-content.html.twig     (and -2 / -3 variants)
field--paragraph--bp-image--bp-image-field.html.twig
```

To override one, copy it into your theme's `templates/` — normal Drupal template resolution
applies; no registry tricks are needed.

## The wrapper-class recipe every template uses

```twig
{{ attach_library('bootstrap_paragraphs/bootstrap-paragraphs') }}
{% set classes = [
  'paragraph',
  'paragraph--type--' ~ paragraph.bundle|clean_class,
  view_mode ? 'paragraph--view-mode--' ~ view_mode|clean_class,
  'paragraph--id--' ~ paragraph.id.value,
  content.bp_width['#items'].getString() ? content.bp_width['#items'].getString(),
  bs.background_color ? bs.background_color,
  content.bp_margin[0]['#markup'] ? content.bp_margin[0]['#markup'],
  content.bp_padding[0]['#markup'] ? content.bp_padding[0]['#markup'],
] %}
<div{{ attributes.addClass(classes) }}>
  <div class="paragraph__column">
    {% if paragraph.bp_header is not empty %}<h2>{{ content.bp_header }}</h2>{% endif %}
    {{ content|without('bp_background', 'bp_header', 'bp_width', 'bp_margin', 'bp_padding') }}
  </div>
</div>
```

Two things make this work and are easy to break:

- The view display renders `bp_width`/`bp_margin`/`bp_padding`/`bp_background` with the
  **`list_key`** formatter (`core.entity_view_display.paragraph.<bundle>.default`). Switch any
  of them to `list_default` and the template starts emitting the human label ("Narrow")
  instead of the class.
- The style fields are then stripped from the printed content with `|without(...)`, so they
  never appear as visible field output.

Bundle-specific templates add to this: the uneven-columns templates merge
`bp_column_style_2` / `bp_column_style_3` into `classes`; `bp_image` wraps the image in
`<a href="{{ content.bp_link.0['#url'] }}">` when `bp_link` is set; `bp_accordion` builds
Bootstrap 5 `accordion-item` markup keyed on `accordion-{{ paragraph.id.value }}` and honours
`bp_show_button` / `bp_accordion_expand`.

`field--paragraph--bp-column-content.html.twig` is what makes columns responsive — it loops
items and wraps each in `<div class="paragraph--type--bp-columns col-sm">`.

## Asset libraries (`bootstrap_paragraphs.libraries.yml`)

| Library | Assets |
|---|---|
| `bootstrap-paragraphs` | `bootstrap-paragraphs.min.css`, `bootstrap-paragraphs-columns.min.css`, `bootstrap-paragraphs-colors.css` |
| `bp-accordion` | accordion CSS + `js/bootstrap-paragraphs-accordion.js`, deps `core/jquery` |
| `bp-carousel` | carousel CSS, deps `core/jquery` |
| `bp-columns` / `bp-columns-two` / `bp-columns-three` | the matching columns CSS |
| `bp-image` | image CSS |
| `bp-modal` | modal CSS, deps `core/jquery` |
| `bp-tabs` | tabs CSS, deps `core/jquery` |

Libraries are attached **from the templates** with `attach_library()`, not from a
`hook_page_attachments`, so a template override that drops the call also drops the CSS.

`css/bootstrap-paragraphs-colors.css` defines the `paragraph--color--*` background classes and
intentionally leaves **five empty classes** for your theme to fill in with brand colours.
Bootstrap itself (grid, `bg-*`, accordion/carousel/modal/tab JS) must come from **your theme** —
the module ships none of it.
