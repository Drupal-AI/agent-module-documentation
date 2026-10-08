# Theming: entity_pager template & library

## Theme hook

`entity_pager` — default template `entity-pager.html.twig` (in the module's `templates/`),
preprocessed by `template_preprocess_entity_pager()`.

### Template variables

| Variable | Meaning |
|---|---|
| `attributes` | wrapper attributes (`entity-pager` class added in template). |
| `content_attributes` | `<ul>` attributes (`entity-pager-list` added). |
| `links` | array keyed `prev` / `all` / `next`; each has `title`, `url`, `attributes`. |
| `current` | 1-based index of the current item, or NULL. |
| `count` | total number of items (`view.total_rows`). |
| `display_count` | bool — whether to render the "N of M" line. |

Each link's `attributes` carry classes `entity-pager-item` plus one of `entity-pager-item-prev`
/ `entity-pager-item-next` / `entity-pager-item-all`; disabled end links get `inactive`.

The template renders a `<ul class="entity-pager-list">` of the links and, when `display_count`
and `current` are set, a `<p class="entity-pager-item-count">{{ current }} of {{ count }}</p>`.
It exposes `{% block links %}` and `{% block count %}` for overriding.

## CSS library

`entity_pager/entity-pager` (`css/entity-pager.css`), attached automatically at preprocess.
Override by adding a library with `libraries-override` in your theme, or supply your own
template suggestion.
