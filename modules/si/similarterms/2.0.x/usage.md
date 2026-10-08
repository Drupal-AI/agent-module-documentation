Similar By Terms provides Views handlers (a contextual filter, a sort, and a field) that rank and display content sharing taxonomy terms with a given node, so you can build "related content" blocks driven by tags.

---

The module adds three Views handlers via `hook_views_data_alter()`, exposed on the `node` table by default: a **contextual filter** `similar_nid` (argument handler `similar_terms_arg`) that takes a node ID and finds other nodes sharing its taxonomy terms, a **sort** `similar_terms_sort` that orders results by similarity, and a **field** `similarterms` (`similar_terms_field`) that outputs the similarity score. Similarity is computed from Drupal core's `taxonomy_index` table by joining candidate nodes on the argument node's term IDs (a LEFT JOIN, so nodes with zero matching terms can still appear, sorted last). The contextual filter can be limited to chosen vocabularies, can include or exclude the argument node itself, and can enforce a minimum-match percentage (25/50/75/100%, where 100% means an exact term set) via a HAVING clause. The field can display the raw count of common terms, a percentage of the source node's terms, or the sum of matching term **weights**; the sort likewise offers count-based or weight-based ordering, letting more important terms (higher taxonomy term weight) dominate recommendations. When the optional Taxonomy Entity Index module is enabled, the handlers are exposed on **every** content entity type (media, users, terms, custom entities) instead of just nodes, using that module's `taxonomy_entity_index` table. There is no admin UI, permissions, or Drush; all configuration is per view.

---

- Build a "Related articles" block that lists other articles sharing the current article's tags.
- Show "You might also like" content ranked by number of shared taxonomy terms.
- Sort a related-content view by similarity, most-similar first.
- Display the similarity score (count of common terms) next to each related item.
- Show similarity as a percentage of the source node's terms (e.g. "75%").
- Show the summed weight of matching terms so important tags rank recommendations higher.
- Limit similarity to a single vocabulary (e.g. only "Topics", ignoring "Content type" tags).
- Restrict a recommendations list to items sharing at least 50% of the source's terms.
- Show only exact matches (100%) — items tagged with the identical term set.
- Include the source node in results for debugging a similarity view.
- Exclude the source node (default) so a "related" list never links to the page you are on.
- Prioritize brand/price tags over color/size tags in e-commerce product recommendations via term weights.
- Recommend similar recipes based on shared ingredient or dietary taxonomy terms.
- Suggest similar events sharing category and location terms.
- Power a "more in this series" block from a shared "series" vocabulary.
- Fill a sidebar with tag-based related content without writing any custom SQL.
- Fall back gracefully: with no minimum match, still fill the list with any content, similarity-ranked.
- Add a secondary Views sort (e.g. random or created date) to break ties when similarity is equal.
- Extend similarity to media entities by enabling Taxonomy Entity Index and using the "Media ID" filter.
- Show related users/profiles that share interest taxonomy terms (with Taxonomy Entity Index).
- Recommend similar taxonomy terms or custom entities sharing term references (with Taxonomy Entity Index).
- Combine the similarity field with a threshold filter to hide weak matches from a block.
- Migrate an old "related content" implementation to a maintainable, config-exported Views setup.
- Provide editors a tag-driven cross-linking mechanism that updates automatically as tags change.
- Drive an RSS/JSON feed of content similar to a given node via a feed display.
