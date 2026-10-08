# Configuration

Setting up best bets is a two‑part job: add a field where editors enter keywords,
then enable a processor on the search index that acts on them. There is no
central settings page — everything happens on the bundle's *Manage fields* tab
and the index's *Processors* tab.

## Part 1 — Add the best‑bets field

1. Go to **Structure**, pick the entity type and bundle you want to curate (for
   example *Content → Article*), and open **Manage fields**.
2. **Add field** and choose the field type **Search API Best Bets**.
3. Give it a label (for example "Best bets") and save.

On the entity's edit form the field's widget shows two text areas inside a
collapsible group:

- **Elevate** — the search queries (comma‑ or newline‑separated) that should push
  this entity to the top of results.
- **Exclude** — the search queries that should remove this entity from results.
  (This box can be hidden per field via the widget's *disable exclude* setting,
  for backends that don't support exclusion.)

When saved, each query is trimmed and lowercased and stored as its own row. You
can adjust each text area's label, placeholder, and help text in the widget
settings on *Manage form display*. A matching formatter is available on *Manage
display* if you want to show the stored best bets when the entity is viewed.

Repeat this for every bundle that should support best bets — the processor can
read best‑bets fields from several entity types on one index.

## Part 2 — Grant editors permission

The best‑bets field is access‑controlled. On **People → Permissions**, grant the
roles that curate search results:

- **View search_api_best_bets keywords** — needed to see the field's values.
- **Edit search_api_best_bets keywords** — needed to change them.

Without these, the field is hidden from view and edit forms even for users who can
otherwise edit the content.

## Part 3 — Enable the processor on your index

1. Go to **Configuration → Search and metadata → Search API**, open your index,
   and switch to the **Processors** tab.
2. Tick **Search API Best Bets** to enable it, then configure it lower on the
   same page:

| Setting | What it does |
|---|---|
| **Fields** | Per‑datasource checkboxes listing the available best‑bets fields. Tick at least one so the processor knows where to read keywords from. |
| **Query handler** | Which backend query handler to use. The list is filtered to handlers that support your index's server backend (the bundled **Solr** handler appears for Solr / Acquia Search servers). |
| **Result elevated flag** | Whether the "elevated" marker is read back from the backend (**query handler**) or computed locally in Drupal from the ids that were sent (**local**). |
| **Elevated score** | An optional relevance score (a float) applied to elevated items. Set it above 0 — for example 100 — to force elevated items to sort first by relevance. Leave at 0 to skip. |

Save the processor settings.

## How matching behaves

At query time the processor lowercases the visitor's search string and looks for
entities whose stored best‑bets query text is **exactly equal** to it (respecting
each entity's view access), then hands the matched elevate/exclude sets to the
query handler. With the Solr handler this becomes Solr's native `elevateIds` /
`excludeIds` parameters — no `elevate.xml` file is generated. Remember that only
simple, scalar search keys are handled and matching is whole‑string exact
equality, so plan your keyword lists accordingly.

## Styling elevated results

Elevated rows are automatically given the CSS class `search-api-elevated` (and an
`elevated` template variable) in Search API Pages results and in Views built on a
Search API index. Target that class in your theme's CSS to make promoted results
stand out. In code you can read the flag with `$item->getExtraData('elevated')`.
