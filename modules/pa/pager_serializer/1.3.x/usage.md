Pager Serializer adds a Views REST-export style plugin that wraps serialized rows alongside a pager object (current page, total items, total pages, items per page), so decoupled front-ends get pagination metadata the standard Serializer omits.

---

The module provides a Views style plugin `pager_serializer` (id `pager_serializer`, "Pager serializer") that extends core REST's `Serializer` style. On a *REST export* display you pick this style instead of the default Serializer, and the rendered output becomes an object with two parts: the serialized rows under a configurable `rows` key, and a `pager` object built from the view's pager (`getItemsPerPage`, `getTotalItems`, `getPagerTotal`, `getCurrentPage`). Every label and every part of the pager is configurable through the `pager_serializer.settings` config object (form at `/admin/config/pager_serializer`, route `pager_serializer.settings`): you can rename `rows` and `pager`, toggle and rename each of `current_page`, `total_items`, `total_pages`, `items_per_page`, and choose whether the pager is nested in its own object (`pager_object_enabled = true`) or flattened onto the top-level response. A second confirm-form route (`pager_serializer.settings.reset`) restores the shipped defaults. Each output row can be modified via `hook_pager_serializer_row_alter(&$row, $result, $view)`. The style also normalises the counts for the "Display all items" (None) and "Display a specified number" (Some) pager types. It requires the core `rest` module; it has config schema but no permissions of its own, no Drush, and no new plugin type.

---

- Return pagination metadata (current page, total items, total pages, items per page) from a Views REST export for a decoupled front-end.
- Give a React/Vue/Next.js client the totals it needs to render pagination controls.
- Wrap serialized rows in a `{ rows: [...], pager: {...} }` envelope instead of a bare array.
- Rename the `rows` and `pager` keys to match a front-end's expected JSON contract.
- Rename individual pager fields (e.g. `total_items` → `count`, `current_page` → `page`).
- Disable pager fields you don't need to keep the payload lean.
- Flatten the pager onto the top-level object (no nested `pager`) via `pager_object_enabled = false`.
- Expose total result counts to an infinite-scroll / "load more" UI.
- Build a JSON API-like response for a headless Drupal site without JSON:API.
- Provide consistent pagination shape across many REST export views from one settings form.
- Add computed/custom fields to each serialized row with `hook_pager_serializer_row_alter()`.
- Enrich rows with related data (e.g. a URL or thumbnail) at serialization time via the alter hook.
- Support "mini pager" (Some) and unpaged (None) displays with correct item/total counts.
- Feed a mobile app the page metadata for server-driven pagination.
- Standardise API pagination labels across environments through exported config.
- Reset all pager labels/flags back to defaults with the built-in reset form.
- Return `items_per_page` so a client can compute how many pages to request.
- Localise or namespace the JSON keys for a specific API consumer.
- Combine with contextual filters and a page offset to power paged search results.
- Replace a hand-rolled custom Serializer subclass with a configurable contrib option.
- Keep the rows payload under a predictable key while pagination lives beside it.
- Drive a data table component that needs both the current slice and the grand total.
- Emit pagination for CSV/XML/JSON formats supported by the serializer.
- Give analytics dashboards total-record counts alongside the current page of data.
