<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `show_more` Views pager plugin

`Drupal\views_show_more\Plugin\views\pager\ShowMore` (extends core `SqlBase`). Pick it in a view's
**Pager** section ("Show more pager"). It is a core Views pager *plugin*, not a new plugin type.

## Options (schema `views.pager.show_more`)

| Option | Default | Meaning |
|---|---|---|
| `show_more_text` | `Show more` | The button label (required). |
| `result_display_method` | `append` | `append` = add next batch after existing rows (AJAX) / refresh (non-AJAX); `html` = **Replace** the content. |
| `initial` | `0` | Items on the **first** page. `0` = same as `items_per_page`. |
| `items_per_page` | (core) | Items loaded **per "Show more" click**. |
| `offset` | (core) | Skip N results. |
| `id` | (core) | Pager id. |
| `effects.type` | `none` | Animation: `none` / `fade` / `scroll` / `scroll_fade`. |
| `effects.speed_type` | `''` | `slow` / `fast` / `custom`. |
| `effects.speed_value` | `''` | Custom speed in ms (required when `speed_type = custom`). |
| `effects.scroll_offset` | `50` | Scroll offset (px) for `scroll`/`scroll_fade`. |
| `advance.content_selector` | `.view-content` | jQuery selector for the rows wrapper (override for custom markup). |
| `advance.pager_selector` | `.pager-show-more` | jQuery selector for the pager. |
| `advance.header_selector` / `advance.footer_selector` | `''` | Optional header/footer selectors. |

The options form hides the core `total_pages`, `expose`, `tags` fields (visually-hidden). Validation
requires `effects.speed_value` when `speed_type = custom`, and copies it into `effects.speed`.

## First-page vs per-click counts (`query()`)

`initial` (or items-per-page when 0) is the first-page LIMIT; each click adds `items_per_page`:
- **AJAX or Replace**: page N uses `OFFSET = initial + (N-1)*items_per_page + offset`,
  `LIMIT = items_per_page` (fetch just the new batch).
- **Non-AJAX Append**: `OFFSET = 0`, `LIMIT = initial + N*items_per_page` (re-fetch the growing set
  so a refresh shows everything).

`getPagerTotal()` accounts for the different first-page size:
`1 + ceil((total - initial) / items_per_page)` when `initial` is set. `render()` returns nothing on
the last page (button hidden) and attaches the JS library when the display is AJAX-enabled.

## Scriptable config

```yaml
# views.view.<id> -> display.<display>.display_options.pager
pager:
  type: show_more
  options:
    items_per_page: 6
    offset: 0
    id: 0
    initial: 12          # 12 first, then 6 per click
    show_more_text: 'Load more'
    result_display_method: append
    effects:
      type: fade
      speed_type: slow
    advance:
      content_selector: '.view-content'
      pager_selector: '.pager-show-more'
```
Set it via the Views UI, or load the view config entity, set the display's `pager`, and save.
