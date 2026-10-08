<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories Promo Page provides a rich, page-builder style directory **entry** type: instead of fixed contact fields, editors compose the entry from LocalGov Paragraphs, so a listing can be a small promotional landing page in its own right.

---

Where `localgov_directories_page` is a structured record, the promo page is unstructured by design. The bundle carries the fields that make it a directory entry — `localgov_directory_channels` and `localgov_directory_facets_select` — plus an address and link fields, and then hands the body of the page over to the LocalGov Paragraphs stack: `localgov_paragraphs`, `localgov_paragraphs_layout` (layout paragraphs for multi-column sections), `localgov_subsites_paragraphs` (the richer subsite component set) and `localgov_paragraphs_views` (embedding views as components). `field_formatter_class` allows per-component styling hooks and `menu_ui` lets a promo page take a menu link like an ordinary page. The result still behaves as a directory entry — it is indexed, facetable and appears in channel listings and search results through the same display ids the parent module expects — but its full view can be as elaborate as a campaign page. This is the heaviest of the entry types in terms of dependencies; sites that do not already run LocalGov Paragraphs should prefer the page or venue bundles.

---

- Give a flagship service a promotional landing page inside a directory.
- Compose a rich entry from images, text and call-to-action components.
- Feature a partner organisation with a multi-section page.
- Build a campaign page that still appears in directory search results.
- Embed a view (e.g. related events) inside a directory entry.
- Lay out entry content in columns using layout paragraphs.
- Give an entry its own menu link.
- Use subsite-style components for a themed area of the site.
- Mix rich promo entries with plain entries in one channel.
- Apply custom CSS classes to individual components.
- Keep the entry facetable and searchable despite its free-form body.
- Provide a landing page for a seasonal service without a new content type.
- Let editors build layouts without developer involvement.
- Reuse the LocalGov Paragraphs component library inside directories.
- Present rich media alongside structured directory data.
- Support a directory of initiatives where each needs its own story.
- Give high-profile venues a richer presentation than the venue bundle allows.
- Publish a promotional entry that links out to an external service.
- Combine structured address data with free-form promotional content.
- Standardise on one paragraphs library across pages and directory entries.
