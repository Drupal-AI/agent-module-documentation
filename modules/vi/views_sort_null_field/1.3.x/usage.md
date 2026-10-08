<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Sort Null Field adds a Views sort handler that orders rows by whether a field is empty (NULL), letting you push empty values to the bottom (or top) of a listing instead of wherever SQL puts them by default.

---

The module solves a common Views annoyance: when you sort ascending by a field, rows whose field is empty float to the top because SQL treats NULL as the lowest value. It registers one Views sort plugin, `null_sort` (`@ViewsSort("null_sort")`), and via `hook_field_views_data_alter()` exposes an extra "… null sort" sort for every **nullable column** of every Field API field. In a view you add that "null sort" handler alongside your normal sort: choose **ASC** to sort NULLs last, **DESC** to sort NULLs first. Internally the handler adds an ORDER BY on the SQL expression `<table>.<column> IS NULL` (1 for empty, 0 for non-empty), so ASC (0 before 1) puts populated rows first and empties last. It has no configuration UI, no settings, no permissions and stores nothing per-site — it is purely a Views-time query addition. The typical recipe is two sorts: the null-sort first (to bucket empty vs non-empty), then the ordinary field sort (to order within each bucket).

---

- Sort a list of products by price ascending but keep items with no price at the bottom.
- Order nodes by an integer "weight" field, empty weights last.
- Put events with no date at the end of an upcoming-events view.
- Show profiles with a completed field first and blanks last.
- Sort a directory by a "priority" field so unset priorities sink to the bottom.
- Reverse it (DESC) to surface rows that are missing a value for a data-cleanup view.
- Combine null sort + regular ascending sort to get "populated, sorted, then empties".
- Keep empty "featured order" fields out of the top of a homepage carousel view.
- Sort taxonomy-term listings by a numeric field with empties last.
- Order users by "last login"-style custom fields, never-logged-in users last.
- Build an admin content view that groups incomplete records (empty field) at the end.
- Sort a table view by an optional date column with blanks at the bottom.
- Prioritise rows that have a value in an optional reference field.
- Create an exposed sort where clicking a header still sends empties to the end.
- Order search-result-like views so items missing a ranking field appear last.
- Sort a "documents" view by an optional file/description field with empties last.
- Push nodes with an empty decimal/float measurement field to the bottom.
- Ensure NULLs land first (DESC) when auditing which records still need data entry.
- Apply per-column null sorting on a multi-column field (e.g. sort by the address's postal_code column emptiness).
- Order a view by an optional link field, unlinked rows last.
- Keep empty boolean/list fields from dominating the top of an ascending sort.
- Use as a drop-in replacement for writing a custom `hook_views_query_alter()` just to handle NULLs.
