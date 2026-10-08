Views Reference Filter (entityreference_filter) adds a Views filter whose option list is populated dynamically from a *separate* Entity Reference view display, letting you restrict an exposed dropdown to a curated set of entities and build dependent (cascading) exposed filters. NOTE: the current release is 2.0.0-beta7 (beta).

---

The module registers a single Views filter plugin, `entityreference_filter_view_result` (extends core `ManyToOne`), and attaches it — via `hook_views_data_alter()` — to every entity-id column (node nid, user uid, taxonomy term tid, etc.) and every entity-reference field (`*_target_id`) as an extra filter handler named `{column}_entityreference_filter`; in the Views UI these appear as "{Field} (entityreference filter)". Instead of listing every entity or being a free-text ID box, the filter's options are produced by running another Views display of type **Entity Reference** whose base entity matches the filtered field's type — so you control exactly which entities appear (and in what order) by editing that reference view. The reference display is stored as `reference_display` ("view_name:display_id") and can receive contextual arguments via `reference_arguments`, where `!n` = the filtered view's URL argument n, `#n` = its contextual filter value n, `[filter_identifier]` = the live value of another exposed filter, and any other token is passed literally. When an argument references another exposed filter's identifier, the two filters become **dependent**: changing the controlling filter re-runs the reference view and updates this filter's options over AJAX (via the `entityreference_filter.ajax` route and the module's JS library); circular dependencies between filters are detected and blocked at save time. Non-exposed, the filter acts as a subquery `IN`/`NOT IN` condition (the reference view is the inner query), giving Views a feature it otherwise lacks. `hide_empty_filter` (default TRUE) hides the exposed widget when the reference view yields no options. It requires only Views and Field from core; the optional `entityreference_filter_search_api` submodule adds a Search-API-index variant, and Better Exposed Filters can rewrite the option labels.

---

- Restrict a taxonomy-term exposed filter to a hand-picked subset of terms instead of the whole vocabulary.
- Show only "featured" or "published" nodes in a node-reference exposed dropdown.
- Populate a user (uid) exposed filter from a view that lists only active editors.
- Build cascading exposed filters: pick a Country, and the City dropdown updates over AJAX.
- Make a taxonomy Category filter drive a dependent Subcategory filter.
- Limit an entity-reference field filter to entities matching the current page's contextual argument.
- Feed the reference view the filtered view's URL argument with `!1` to context-scope the options.
- Pass a contextual filter value into the reference view with `#1`.
- Chain another exposed filter's value into the option query with `[identifier]`.
- Add a subquery `IN` condition to a view (rows whose nid is in another view's result set).
- Add a `NOT IN` subquery to exclude rows returned by a second view.
- Curate the order of dropdown options by sorting the reference view (the view is the source of truth for order).
- Hide an exposed filter automatically when its curated option list comes back empty (`hide_empty_filter`).
- Combine with Better Exposed Filters to relabel or restyle the curated options.
- Provide an exposed filter of only the terms actually used on a given content type.
- Filter an events view by venue, where venues are limited to a specific region view.
- Let editors filter a products view by brand, brands sourced from a "top brands" view.
- Build a two-level location filter (Region → Store) that stays in sync via AJAX.
- Restrict a node-reference filter's options by the value of a separate status filter.
- Reuse one reference view display across multiple filtered views for consistent option lists.
- Give exposed filters options driven by access-controlled views (options respect the reference view's access).
- Ensure filter option cache tags follow the referenced entity type so lists invalidate correctly.
- Replace a giant "- Any -" term dropdown with a short, relevant, dynamically generated list.
- Drive a Search API view's exposed reference filter from a curated reference view (via the Search API submodule).
