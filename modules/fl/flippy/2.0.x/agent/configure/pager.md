# Configure a Flippy pager (per content type)

Flippy has **no central settings form and no `configure` route**. You turn it on and configure it
on each **content type's edit form** (`/admin/structure/types/manage/<type>`), in the collapsible
**"Flippy settings"** group (added by `flippy_form_node_type_edit_form_alter()`). A custom submit
handler writes every option into the shared `flippy.settings` config object as a
`<key>_<type>` entry.

## Where it renders

When `flippy_<type>` is on, `flippy_entity_extra_field_info()` exposes a **`flippy_pager`**
pseudo-field on that bundle's *Manage display* (`/admin/structure/types/manage/<type>/display`).
Drag it where you want the pager among the node's fields, or hide it (the links are still
available to the theme/block). You can alternatively place the **"Flippy Block"** (`flippy_block`).

## All `flippy.settings` keys (each suffixed with the content-type machine name)

| Key (`…_<type>`) | Type | Meaning |
|---|---|---|
| `flippy_` | bool | Master on/off: build a pager for this content type. |
| `flippy_head_` | bool | Add semantic `rel="prev"`/`rel="next"` `<link>` tags to the page `<head>`. |
| `flippy_show_empty_` | bool | Render an empty (link-less) label when there is no prev/next node. |
| `flippy_prev_label_` | string | Label for the Previous link (supports tokens). |
| `flippy_next_label_` | string | Label for the Next link (supports tokens). |
| `flippy_first_last_` | bool | Show First and Last links. |
| `flippy_first_label_` | string | Label for the First link. |
| `flippy_last_label_` | string | Label for the Last link. |
| `flippy_loop_` | bool | Wrap around (Next on last → first, Prev on first → last). |
| `flippy_random_` | bool | Show a Random link. |
| `flippy_random_label_` | string | Label for the Random link. |
| `flippy_truncate_` | int | Max label length after token replacement (empty = no truncation). |
| `flippy_ellipse_` | string | String appended when a label is truncated. |
| `flippy_press_swipe_` | bool | Keyboard/swipe nav (only offered when the `hammerjs` module is enabled). |
| `flippy_custom_sorting_` | bool | Sort by something other than ascending post date. |
| `flippy_sort_` | string | Field/property to sort the pager by (when custom sorting is on). |
| `flippy_order_` | `ASC`/`DESC` | Sort direction (when custom sorting is on). |

Default order (no custom sorting) is `created` **ASC**.

## Read / write with drush

```bash
# Is Flippy on for Article?
drush cget flippy.settings flippy_article

# Turn Flippy on for Article and add head links:
drush cset flippy.settings flippy_article 1 -y
drush cset flippy.settings flippy_head_article 1 -y

# Custom sort Article by a date field, newest first:
drush cset flippy.settings flippy_custom_sorting_article 1 -y
drush cset flippy.settings flippy_sort_article field_event_date -y
drush cset flippy.settings flippy_order_article DESC -y
```

In PHP: `\Drupal::configFactory()->getEditable('flippy.settings')->set('flippy_article', TRUE)->save();`

## Notes

- Labels support **tokens** (node token type). The Token module, when enabled, adds a token
  browser to the form; core's `token` service does the replacement either way.
- The sort field select on the form only lists base fields / fields whose value column is
  `varchar`, `int`, or a `datetime` field.
- There is no config schema, so keys are plain scalars under `flippy.settings`.
