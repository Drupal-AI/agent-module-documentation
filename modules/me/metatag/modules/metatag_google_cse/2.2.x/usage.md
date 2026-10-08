Adds the meta tags Google Custom Search Engine (CSE) / Programmable Search uses to enrich and rank indexed pages.

---

Google Custom Search Engine (now Programmable Search) lets you build a scoped Google search over your own sites, and it reads a handful of page-level meta tags to refine results — audience targeting, departmental grouping, document status, and a preferred thumbnail. This submodule registers those tags as Metatag plugins so they can be set as defaults or per entity with token support. Depends on the main Metatag module. Useful for intranets, portals, and sites that embed a Google Programmable Search box.

---

- Set a result thumbnail image with `thumbnail`.
- Target an audience segment with `audience`.
- Group pages by `department` for faceted CSE results.
- Mark a page's `doc_status` (e.g. draft/final) for filtering.
- Influence how pages appear in a site's CSE results.
- Provide better thumbnails in Programmable Search results.
- Set CSE tags globally as defaults.
- Override CSE tags per content type.
- Populate the thumbnail from a token/image field.
- Improve internal search relevance on an intranet.
- Facet results by department across a large site.
- Distinguish draft vs. published docs in search.
- Keep CSE metadata in exportable config.
- Standardize CSE tagging across a multisite.
- Support a scoped Google search box on a portal.
- Enrich search snippets with structured hints.
