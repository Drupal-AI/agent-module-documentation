Entity list is a configuration-driven framework for building lists/collections of entities (a lightweight, plugin-based alternative to Views) that are placed as blocks or viewed on their own admin route.

---

The module defines an `entity_list` config entity. Each list is assembled from swappable plugins: an **EntityListQuery** plugin fetches the entity IDs (a Drupal entity query by type/bundle/language/pager, a contextual query that reads a reference field on the current or host entity, or a filter-aware query that applies request-driven filters and sorts), and an **EntityListDisplay** plugin renders the result set through a Layout Discovery layout with draggable regions for the item list, total count, two pagers and — with the filter display — an exposed filter form. Extra configuration tabs come from **EntityListExtraDisplay** plugins, exposed filter widgets from **EntityListFilter** plugins (search, date, taxonomy, custom list) and sort widgets from **EntityListSortableFilter** plugins. Each saved list automatically becomes a placeable block (`entity_list_block:<id>` derivative), can be shown on its canonical admin route, or embedded on a host entity through the `entity_list_reference_field_formatter` field formatter. Developers extend it by adding plugins and by implementing `hook_entity_list_query_alter()` / `hook_entity_list_query_<id>_alter()`. It requires only core `layout_discovery`; `fapi_collapsible` is optional for collapsible filters.

---

- Build a paged list of published Article nodes without creating a View.
- Create a list of the most recent nodes of several bundles at once.
- Show a language-filtered list that automatically follows the current page language ("Auto").
- Place a generated list anywhere as a block via the auto-derived Entity list block.
- Display a list on its own page through the entity's canonical admin route.
- Embed a per-entity list on a node using the Entity list reference field formatter.
- Render a contextual list of entities referenced by a field on the entity currently being viewed.
- Render a list of entities referenced by the host entity that embeds the list (use-host mode).
- Add an exposed keyword search filter across selected text fields of the listed nodes.
- Add exposed taxonomy-term filters (OR/AND) driven by a node's term reference fields.
- Add an exposed date filter over created/changed/datetime/daterange fields.
- Add a custom-list exposed filter with admin-defined options.
- Offer visitor-facing sort controls with the Global sortable filter.
- Apply contextual (non-exposed) filters such as published/promoted/sticky to a list.
- Choose the entity view mode used to render each item in the list.
- Add a "total items" element with custom singular/plural text.
- Configure two independent pagers (top and bottom) for a list.
- Pick a Layout Discovery layout and drag list elements into its regions.
- Add custom CSS classes to the list wrapper and to individual items.
- Provide theme overrides per list via `entity_list_item__<list_id>` and `form__entity_list_filter_form__<list_id>` suggestions.
- Alter a specific list's query in custom code with `hook_entity_list_query_<id>_alter()`.
- Register a new data source by adding an EntityListQuery plugin.
- Register a new rendering style by adding an EntityListDisplay plugin.
- Add a new exposed filter widget by adding an EntityListFilter plugin.
- Restrict who can build lists with the "administer entity list" permission and who can see them with "view entity list".
- Reuse the same list configuration as both a block and a reference-formatter display.
- Migrate legacy ecedi_list configurations to the Drupal 10/11 entity_list equivalent.
