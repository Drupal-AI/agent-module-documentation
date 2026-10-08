<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — Read More Extra Field (1.x)

Theme hook `readmore_extrafield` (registered in `readmore_extrafield_theme()`), default
template `templates/readmore-extrafield.html.twig`.

Default markup — a field-like wrapper (extra fields carry no field markup of their own, so
the template fakes the core field structure) around a single Twig `link()`:

```twig
<div {{ wrapper_attributes.addClass([
    'field-wrapper',
    'field field--name-extra-field-readmore-extrafield',
    'field--type-extra-field',
]) }}>
  <div {{ item_attributes.addClass('field__item') }}>
    {{ link(link.title, link.url, link.attributes.addClass('button')) }}
  </div>
</div>
```

The rendered anchor therefore carries both `read-more` (set in `readmore_extrafield_node_view()`)
and `button` (added in the template); the wrapper `<div>` carries `readmore-extrafield` plus the
three field classes above.

## Variables (1.x — different from 3.x)

| Variable | Type | Notes |
|---|---|---|
| `link` | array | `title` (string, hardcoded `t('Read more')`), `url` (`Drupal\Core\Url`, the node canonical), `attributes` (`Attribute`, class `read-more`). |
| `item_attributes` | `Attribute` | Field-item wrapper attributes (empty by default). |
| `wrapper_attributes` | `Attribute` | Outer wrapper attributes (class `readmore-extrafield`). |
| `view_mode` | string | The render view mode. |
| `entity` | node | The host node. |

Note the shape differs from the 3.x line, whose template exposes flat `title` / `url` /
`attributes`. A 1.x template override is **not** forward-compatible with 3.x — the project's
own upgrade note calls this out.

Output is built with Twig's `link()`, which autoescapes the (static) title and safely renders
attributes.

## Theme suggestions

`readmore_extrafield_theme_suggestions_readmore_extrafield()` provides, in order (dots in the
view mode become underscores). Because 1.x is node-only, the suggestions omit an entity-type
segment and key off the bundle directly:

- `readmore_extrafield__{view_mode}`
- `readmore_extrafield__{bundle}`
- `readmore_extrafield__{bundle}__{view_mode}`
- `readmore_extrafield__{entity_id}`
- `readmore_extrafield__{entity_id}__{view_mode}`

e.g. `readmore-extrafield--article--teaser.html.twig`, or
`readmore-extrafield--article.html.twig`.

To change the label or add attributes in 1.x you must override this template (or the
suggestions above) in your theme — there is no settings form. For a settings-driven approach,
use the 3.x line instead.
