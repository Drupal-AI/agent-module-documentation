# Enable & configure the Infinite Scroll pager

There is no admin settings page — configuration lives in a **View's pager settings**.

1. Edit a View (`/admin/structure/views/view/<id>`).
2. In **Pager**, click "Full" / "Mini" and choose **Infinite Scroll** (`infinite_scroll`).
3. Under **Advanced → Use AJAX**, set to **Yes** (required — the View edit form warns you if
   AJAX is off, since the pager cannot append pages without it).
4. Set **Items to display** as normal; that becomes the batch size per load.

## Pager options (`defineOptions()` → stored under `views_infinite_scroll`)
Schema: `views.pager.infinite_scroll` (`config/schema/views_infinite_scroll.schema.yml`).

| Option | Type | Meaning |
|---|---|---|
| `button_text` | string | Label of the "load more" button (e.g. `Load More`). |
| `automatically_load_content` | bool | If TRUE, next page loads automatically on scroll; if FALSE, only on button click. |
| `initially_load_all_pages` | bool | Load all pages up to the current one on initial render (deep-linking to a later page). |

The pager extends the SQL pager, so items-per-page, offset, and exposed items work as usual.
