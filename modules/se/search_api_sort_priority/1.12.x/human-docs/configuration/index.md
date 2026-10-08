# Configuration

Search API Sort Priority has no form of its own — you configure it entirely on
your existing Search API index. The pattern is always the same: enable a
processor, set the priority order, re-index, then add the generated weight field as
a sort in your search view.

## 1. Enable a processor on your index

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and open the **index** you want to affect.
2. Click the **Processors** tab.
3. Tick the processor that matches how you want to rank results:
   - **Content type** — rank node content types.
   - **Media bundle** — rank media types.
   - **Paragraph bundle** — rank paragraph types.
   - **File MIME type** — rank files by type.
   - **Role** — rank by the author's highest role.
   - **Statistics** — rank by a node's total view count.

   Each processor only appears if it makes sense for your index. For example, the
   File MIME type processor shows up only when the index has a file datasource, and
   the Content type, Role, and Statistics processors need a node datasource.

## 2. Set the priority order

Scroll down to the **Processor settings** section further down the same page; each
enabled processor gets its own settings area.

- For most processors you see a **drag-and-drop weight table** listing the bundles
  (or roles, or MIME types). Drag the rows into the order you want, or type explicit
  weight numbers. A **lower (or more negative) weight means higher priority** when
  you sort ascending — so drop the items you want on top toward the top of the
  table.
- The **Statistics** processor has no table — it simply uses each node's view
  count as the weight, so there is nothing to arrange.

Click **Save** to store the settings. (These weights are saved as part of the
Search API index configuration, not in a separate config object.)

## 3. Re-index

Enabling a processor adds a new hidden integer field to the index — named after
the processor, such as `contentbundle_weight`, `mediabundle_weight`,
`paragraphbundle_weight`, `filemime_weight`, `role_weight`, or
`statistics_weight`. That field is populated as items are indexed, so **re-index**
the content (from the index's main page or with `drush search-api:index`) before
the weights take effect. The field is hidden, so it never shows up in your result
display — it exists only for sorting.

## 4. Sort your search results on the weight field

The weight only changes the ranking once you actually sort on it:

- **Views-based search** — edit the Search API **view** that shows your results,
  add a **Sort criteria**, and pick the weight field (for example *Content type
  weight*). Choose ascending order so lower weights rank first. Add it above (or
  below) the relevance/score sort depending on whether you want editorial priority
  to lead or merely to break ties.
- **Solr search** — with the `search_api_sort_priority_solr` submodule enabled, add
  the weight field as a Solr sort in the same way.

## Tips

- You can enable **more than one** processor on the same index and sort on several
  weight fields for layered ranking (for example content type first, then view
  count).
- To re-order priorities later, just drag the rows again on the Processors tab,
  save, and re-index.
- Different indexes can use completely different priority schemes.
