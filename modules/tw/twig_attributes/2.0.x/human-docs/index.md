# Twig Attributes — manual setup guide

**Twig Attributes** (`twig_attributes`) is a small helper for theme developers. It
adds an `add_attr` Twig filter (with `with_attr` as an exact alias) that lets you
set HTML attributes — a class, an id, a `data-*` hook, an ARIA attribute — on
elements *inside* a render array, straight from a Twig template. Normally, adding
an attribute to a rendered field means creating a template override or writing a
preprocess hook; this filter lets you do it inline in one expression instead.

It also solves a common frustration: some core field elements — links and images
in particular — don't render `#attributes` you set on them by default. To fix
that, the module quietly extends a few core templates (`image_formatter`,
`responsive_image_formatter`, and `file_link`) so they accept and render
attribute variables. That means you *can* add classes, `loading="lazy"`,
`rel="nofollow"`, `target="_blank"`, data‑attributes, and the like to rendered
image and link fields — something that's otherwise awkward.

This is a **pure developer/theming tool**: there is no configuration form, no
permissions, no schema, no Drush commands, and no module dependencies. You enable
it and then use the filter in your templates. It runs on Drupal 10 and 11.

This guide is written for a **human**. If you want a terse, token‑cheap reference
for an AI coding agent — including the full filter signature and argument table —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

(There's no configuration page — this module has no settings. Everything happens
in your Twig templates, described below.)

## Where it lives in the admin menu

Nowhere — there is no admin UI. Once enabled, the `add_attr` / `with_attr` filter
is simply available in every Twig template.

## How to use it

The filter takes the render array you pipe into it, plus up to four arguments:

```twig
{{ build|add_attr(key, attributes, add_to_children = true, override = false) }}
```

- **`key`** — the render‑array property that should receive the attributes. A
  leading `#` is added for you, so `'image_attributes'` becomes `#image_attributes`.
- **`attributes`** — a map of attribute name → value (the value can be a string or
  an array), e.g. `{class: ['my-class'], id: 'foo'}`.
- **`add_to_children`** *(default `true`)* — apply the attributes to each child
  element of the render array; pass `false` to target the top‑level element
  instead.
- **`override`** *(default `false`)* — by default, array values (like `class`) are
  deep‑merged with any existing values; pass `true` to replace them instead.

Some examples:

```twig
{# Add a CSS class to an image field's <img> #}
{{ content.field_img|add_attr('image_attributes', {class: ['my-class']}) }}

{# Add an id to a link field's <a> #}
{{ content.field_link|add_attr('link_attributes', {id: 'custom-id'}) }}

{# Chain the filter to set attributes on several elements at once #}
{{ content.field_image
   |add_attr('image_attributes', {class: ['custom-image-class']})
   |add_attr('link_attributes', {class: ['custom-link-class']}) }}
```

### Which `key` to use with the supported core templates

The filter only *sets* a render‑array property — the template still has to render
it. These are the core templates the module teaches to render attributes:

| Template | Keys you can set |
|---|---|
| `image_formatter` | `image_attributes` (on the `<img>`), `link_attributes` (on the link) |
| `responsive_image_formatter` | `image_attributes` (on the `<img>`), `link_attributes` (on the link) |
| `file_link` | `link_attributes` (on the file `<a>`) |

For any other element, use whatever property that element's own template reads —
most commonly `attributes`, e.g. `|add_attr('attributes', {class: ['x']})`.
