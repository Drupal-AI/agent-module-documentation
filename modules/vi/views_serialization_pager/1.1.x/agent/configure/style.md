# Serialization with Pager style

## Plugin
`Drupal\views_serialization_pager\Plugin\views\style\ViewsSerializationPager` extends
`Drupal\rest\Plugin\views\style\Serializer`.
```
@ViewsStyle(
  id = "views_serialization_pager",
  title = "Serialization with Pager",
  display_types = {"data"}
)
```
It inherits all of the core Serializer's format handling (accepted request formats, content
negotiation). It adds **no settings** of its own — only the row/format options from the parent.

## Output shape
`render()` collects `rows` from the row plugin (Data entity or Data field), reads the active pager, and
returns:
```json
{
  "rows": [ /* serialized rows */ ],
  "pager": {
    "current_page":   0,
    "total_items":    42,
    "total_pages":    5,
    "items_per_page": 10
  }
}
```
serialized to the display's negotiated content type (JSON, XML, …). Pager values come from
`$this->view->pager`: `getCurrentPage()`, `getTotalItems()`, `getItemsPerPage()`, and
`getPagerTotal()` for `total_pages`. For the `None` ("Display all items") and `Some` ("Display a
specified number of items") pager plugins — and mocked pagers in tests — `total_pages` is left at `0`
(those pagers do not compute a page total).

## Configure a REST Export view
1. *Structure → Views → Add view*; enable "Provide a REST export" (or add a REST Export display).
2. Set the display **Path**.
3. **Format → Serializer** settings: choose **"Serialization with Pager"** as the style.
4. In the style settings, tick the accepted request formats (e.g. `json`, `xml`).
5. **Pager**: use "Full" (or "Paged output, full pager") so `?page=N` navigation and the `total_pages`
   metadata work as expected.
6. Save; request the path (optionally `?page=1`) to get the `{rows, pager}` envelope.

## Notes
- Choose the row plugin per need: "Data (entity)" runs entities through normalizers; "Data (field)"
  outputs field values directly through the encoder.
- With `None`/`Some` pagers you still get `rows` but `total_pages` will be `0` — use "Full" for real
  pagination metadata.
