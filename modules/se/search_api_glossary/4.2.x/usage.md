<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API AZ Glossary adds an A–Z (first-letter) glossary facet to Search API indexes: a Search API processor derives a "glossary" field from a text field (node title, username, etc.), and a Facets widget renders the A B C … navigation.

---

The module plugs into Search API and Facets. Its core is a **Search API processor plugin** (`id: glossary`, "Glossary processor") that, for each source field you enable glossary on, exposes a hidden computed field named `glossaryaz_<field>` (prefix `glossaryaz_`) whose value is the uppercased first letter — or a group label — of the source value. The letter/group is computed by the `search_api_glossary.helper` service (`GlossaryHelper::glossaryGetter()`), which takes the first character, lets modules alter it via `hook_search_api_glossary_source_alter()`, then optionally maps it to a group: alpha → the `alpha` prefix, numeric → `numeric`, other → `special`. Those group labels live in the `search_api_glossary.settings` config object under `group_prefix` (defaults `alpha: "A-Z"`, `numeric: "0-9"`, `special: "#"`). On the Facets side it provides a widget (`glossaryaz`, "Glossary AZ") and three facet processors: `glossaryaz_all_items_processor` (show all A–Z even when empty), `glossaryaz_pad_items_processor` (add missing letters) and `glossaryaz_widget_order` (sort A–Z). It supports any Search API backend (DB, Solr, Elasticsearch) and works with Views, Search API Pages and Facets. There is no admin settings form of its own — you enable the processor on an index, mark which fields are "glossary", index, then build a facet on the `glossaryaz_*` field with the Glossary AZ widget.

---

- Add an A–Z glossary navigation to a directory of people indexed by username.
- Provide first-letter browsing of a glossary/terminology node list.
- Build an alphabetical index of article titles as a Facets block.
- Group all numeric-starting titles under a single "0-9" facet item.
- Group non-alphanumeric titles under a "#" facet item.
- Localise the group labels (e.g. change "A-Z" to another language) via `group_prefix`.
- Show every letter A–Z in the facet even when some have no results (all-items processor).
- Pad the glossary facet with missing letters so the A–Z bar is always complete.
- Sort the glossary facet items in strict A–Z order (widget-order processor).
- Expose a `glossaryaz_title` computed field on a node index for faceting.
- Create first-letter browsing for a large catalogue backed by Solr.
- Use the same glossary facet across Views and Search API Pages.
- Add multiple glossary facets (e.g. by title and by author) on one index.
- Normalise accented first letters (À→A) before grouping via the source-alter hook.
- Provide a compact alphabet bar on a taxonomy/term listing indexed in Search API.
- Offer letter-based filtering on a member directory search page.
- Combine the glossary facet with other Search API facets (type, date) on one page.
- Drive an alphabetical "jump to letter" UI without custom code.
- Reuse the GlossaryHelper service to compute a first-letter/group value in custom code.
- Support Drupal DB search when no Solr/Elasticsearch server is available.
- Keep glossary group labels in exportable config for deployment.
- Build an A–Z author index for a publications site.
- Give a knowledge base an alphabetical topic browser.
- Theme the glossary facet using the Facets widget theming.
