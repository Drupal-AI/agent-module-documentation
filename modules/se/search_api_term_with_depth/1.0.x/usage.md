<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Term With Depth provides a Search API index tid with depth filter.

---

Search API Term With Depth provides a **Search API Views filter that matches a taxonomy term with depth** —
selecting a term also matches its descendant (child) terms, so a facet/filter on a category includes content
tagged with its subcategories. It depends on the Search API module, in the Search package.

Use it for hierarchical taxonomy filtering in Search API views. It is a search/query-convenience feature
(reviewed CLEAN): it expands the selected term into its descendant/ancestor tids and adds them as query
conditions — the underlying Search API query still applies index/View access, and it exposes no content and has
no access role. Configure the filter on a Search API view.

---

- Filter Search API by term with depth.
- Match a term and its descendants.
- Include subcategory content.
- Depend on the Search API module.
- Expand a term into child tids.
- Serve hierarchical filtering.
- Apply the index/View access.
- Expose no content.
- Have no access role.
- Configure the filter.
- Handle depth filtering.
- Filter by depth.
- Configure the view.
- Handle the filter.
- Match descendants.
- Configure Search API.
- Handle taxonomy depth.
- Filter terms.
- Set the filter.
- Provide depth filtering.
