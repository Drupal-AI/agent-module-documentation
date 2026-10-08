# Configuration

The widget is set up per Search API index, on top of the sorts you have already
enabled in the Search API Sorts module. In short: enable the sorts you want, then
switch that index over to the form widget and give each sort readable labels.

## Set it up

1. Log in as a user with the **Administer Search API** permission (and note the
   module's own `administer search_api_sorts_widget` permission at **People →
   Permissions**).
2. Go to your search index at **Configuration → Search and metadata → Search API →
   [your index]** (`/admin/config/search/search-api/index/[INDEX]`).
3. On the **Sorts** tab, enable the sort fields you want visitors to be able to
   sort by.
4. Switch to the **Sorts widget** tab.
5. Select **Use form widget** (this is the "Active" option) to replace the list of
   sort links with the dropdown / radio control.
6. Optionally enable **auto-submit**, so choosing a sort applies it without a
   separate button press.
7. For each sort field, provide the **ascending** and **descending** labels — this
   is what lets you show friendly wording like "Newest first" and "Oldest first"
   rather than a bare field name and direction.
8. Save the settings.

## Placing the widget as a block

Because the widget is rendered through core's Block system, place it where you want
it to appear on the page (for example in a sidebar next to your facets) at
**Structure → Block layout** (`/admin/structure/block`), assigning it to the region
that suits your search results layout.

## A couple of things to get right

- **Keep a non-JavaScript path.** Auto-submit is convenient, but make sure a
  visitor without working JavaScript can still apply their chosen sort — otherwise
  the control does nothing for them.
- **Keep the sort in the URL.** A sort reflected in the page's query string can be
  bookmarked, shared and reached again with the back button; one held only in the
  session cannot.
