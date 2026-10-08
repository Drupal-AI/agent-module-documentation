Synonyms Views Filter provides a Views filter that matches entities by their name or any of their synonyms, usable as an exposed filter with an autocomplete or select widget.

---

The submodule registers a Views **filter** plugin `synonyms_entity` (`FilterPluginBase`) and, via
`hook_views_data()` (`synonyms_views_filter_views_data()`), attaches a "Synonyms of <entity type>" filter
to every content entity type's base table (real field = the entity's id key). The filter offers a
**widget** option — reusing the synonyms behavior widget services (`synonyms.behavior_service->
getWidgetServices()`, i.e. autocomplete or select) — and a **target_bundles** option, so an exposed
filter can present a synonyms-aware autocomplete/select control. Matching resolves the typed name or
synonym to entity IDs (through the Synonyms provider service) and constrains the View's rows accordingly.
It has no settings page, schema, or permissions of its own; you add and configure it inside a View.
Depends on `synonyms` + core `views` (and, to use widgets, the relevant widget submodule such as
`synonyms_autocomplete` or `synonyms_select`).

---

- Add an exposed filter that finds content by an entity's name or synonym.
- Let site visitors filter a listing by typing an alias in an autocomplete.
- Present the exposed filter as a synonyms-friendly select dropdown.
- Filter a View of nodes by a referenced term or its synonyms.
- Restrict the filter to specific target bundles.
- Build alias-aware faceting on top of core Views.
- Match "USA"/"United States" to the same term in a filtered listing.
- Reuse autocomplete or select widget behavior in the exposed filter.
- Combine with the synonyms Views field to filter and display aliases together.
- Provide user-friendly filtering without exposing raw entity IDs.
- Attach a synonyms filter to any content entity type automatically.
- Support single or bundle-scoped entity matching in the filter.
- Improve findability in admin content Views via synonym search.
- Offer memorable, alias-based query controls to end users.
- Drive a "search by any known name" listing page.
