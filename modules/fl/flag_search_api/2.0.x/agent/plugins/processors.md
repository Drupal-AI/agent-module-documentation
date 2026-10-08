# Flag Search API — processors, Views field, facet widget

These are plugins for other modules' plugin systems (Search API, Views, Facets); this module defines no
plugin type of its own.

## Search API processors (`src/Plugin/search_api/processor/`)

Enable on a Search API index at *Admin → Config → Search & metadata → your index → Processors*, then in
the processor settings tick which flags to index (`flag_index` config = array of flag IDs).

| Processor id | Class | Adds field(s) | Value |
|---|---|---|---|
| `flag_indexer` | `FlagIndexer` | `flag_<flag_id>` (multi-valued integer) | User IDs of everyone who flagged the item (`FlagService::getFlaggingUsers()`). |
| `flag_count_indexer` | `FlagCountIndexer` (extends `FlagIndexer`) | `flag_<flag_id>_count` (integer) | Count of flaggings for the item. |

Mechanics: `getPropertyDefinitions()` (datasource-independent) exposes the fields;
`preIndexSave()` calls `ensureField()` for each; `addFieldValues()` populates values at index time.
Both stages run at weights `add_properties: 1`, `pre_index_save: -10`. Errors are logged to channel
`flag_search_api`. Injects `@flag` and a logger.

## Views field: `search_api_flag`

`src/Plugin/views/field/SearchApiFlag.php` (`@ViewsField("search_api_flag")`). Registered onto each
indexed `flag_<id>` field by `flag_search_api_views_data_alter()` (in `flag_search_api.views.inc`).
`render()` parses the Search API item id (`entity:type/id:langcode`) and the `flag_<id>` field name,
then returns Flag's `flag.link_builder:build` lazy builder so a flag/unflag link renders on the row.

## Facets widget: `user_flag`

`src/Plugin/facets/widget/UserFlagWidget.php` (`@FacetsWidget id="user_flag"`), extends
`WidgetPluginBase`, injects `@current_user`. Configure a facet on a `flag_<id>` field and pick the
"User Flags" widget. It renders a single checkbox (labels: `flags_label` default "My Flagged Items",
`no_flags_label` "No Flagged Items Available") that filters the search to items whose `flag_<id>` field
contains the current user's uid — i.e. "show only content I flagged".

## Privacy note (not a security finding)

`flag_indexer` stores the **uids of users who flagged each item** in the search index. Whether those
uids surface to end users depends entirely on how a site builder configures Views fields / facets over
that field (a normal `administer search_api` / `administer views` decision). Keep flag-user fields out
of public-facing displays if who-flagged-what should stay private.
