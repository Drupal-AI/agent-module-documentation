<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — Read More Extra Field

Theme hook `readmore_extrafield` (registered in `readmore_extrafield_theme()`), default
template `templates/readmore-extrafield.html.twig`.

Default markup:

```twig
<div class="readmore-extrafield">{{ link(title, url, attributes) }}</div>
```

## Variables (changed in 3.x)

| Variable | Type | Notes |
|---|---|---|
| `title` | string | Link label (resolved `link_title`, tokens already replaced). |
| `url` | `Drupal\Core\Url` | `entity.node.canonical` for the host node. |
| `attributes` | array | Anchor attributes: always `class: ['readmore-extrafield-link', …]` plus any `title`/`rel`/`target` set in settings. |
| `entity` | `ContentEntityInterface` | The host node. |
| `view_mode` | string | The render view mode. |

Output is built with Twig's `link()`, which autoescapes the title and safely renders
attributes. Override the template in your theme to change wrapper markup.

## Theme suggestions

`readmore_extrafield_theme_suggestions_readmore_extrafield()` provides these suggestions
(dots in the view mode are converted to underscores; skipped entirely if `entity` or
`view_mode` is empty):

- `readmore_extrafield__{view_mode}`
- `readmore_extrafield__{entity_type}`
- `readmore_extrafield__{entity_type}__{view_mode}`
- `readmore_extrafield__{entity_type}__{bundle}`
- `readmore_extrafield__{entity_type}__{bundle}__{view_mode}`
- `readmore_extrafield__{entity_type}__{entity_id}`
- `readmore_extrafield__{entity_type}__{entity_id}__{view_mode}`

e.g. `readmore-extrafield--node--article--teaser.html.twig`.

**Upgrade note:** if you overrode the 1.x template, update it — the available variables
changed in 3.x (`readmore_extrafield_update_8301` warns about this).
