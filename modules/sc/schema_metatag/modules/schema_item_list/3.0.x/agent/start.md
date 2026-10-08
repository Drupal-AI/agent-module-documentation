# schema_item_list — agent start

Submodule of [schema_metatag] (also depends on `metatag_views`). Adds a Metatag group
`schema_item_list` (`@type` ItemList) with Tag plugins for ItemList properties (itemListElement,
mainEntityOfPage, @id). Attach to a View display via metatag_views to build search carousels;
configure the tags with tokens under **Metatag** settings; values render as JSON-LD via
schema_metatag. No config UI of its own.
