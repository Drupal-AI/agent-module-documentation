# Use the synonyms Views filter

No admin form of its own — configure it inside a View.

1. Edit a View on a content entity type, **Add → Filter criteria**, choose **"Synonyms of <entity type>"**
   (plugin `synonyms_entity`; it's attached to the entity's base table with `real field` = the id key).
2. Configure the filter:
   - **Widget** — pick a synonyms behavior widget (Autocomplete or Select). These come from
     `synonyms.behavior_service->getWidgetServices()`, so the relevant submodule
     (`synonyms_autocomplete` / `synonyms_select`) must be enabled and its behavior configured.
   - **Target bundles** — optionally restrict which bundles are matched.
3. Tick **Expose this filter** to let visitors use it; the chosen widget renders the exposed control.

At query time the filter takes the typed name/synonym, resolves it to entity IDs via the Synonyms
provider service, and constrains the View's rows to those IDs. A Synonym provider must be configured for
the target entity type/bundle for synonym matches to work (name matches work regardless).
