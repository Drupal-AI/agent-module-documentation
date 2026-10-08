<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Publications turns long documents — strategies, plans, annual reports — into structured **HTML publications** with chapters and navigation, so a council publishes readable, accessible web pages instead of a PDF.

---

Public-sector organisations produce long formal documents, and the default publication route is a PDF, which is poor for accessibility, poor on mobile, unsearchable in site search and impossible to update in part. This module models the alternative — a multi-page HTML publication with a contents page, chapter navigation and next/previous links — on core's **Book** hierarchy. It ships two content types: `localgov_publication_page` (the chapters, arranged into a Book outline, single-page publications allowed) and an optional `localgov_publication_cover_page` (a landing page that references one or more publications and can attach a downloadable document, e.g. a PDF, for people who don't want to read online). It re-uses `\Drupal\book\Form\BookAdminEditForm` behind its own `publication.admin_edit` route (`/admin/structure/publications/{node}`, gated by `administer book outlines` + `_entity_access: node.view`) for re-ordering, relabels "book" as "publication" throughout the node forms, and — when Book is installed — deletes the stock Book content type so editors only see publication types. Three blocks provide publication navigation, a per-page table of contents (built from `h2` anchors added by its `localgov_publications_heading_ids` filter on the `wysiwyg` format), and a publication page header. Pathauto builds chapter URLs from two custom tokens (`localgov-publication-path`, `localgov-publication-cover-page-alias`), and saving a cover page regenerates the aliases of every page in its publications. One permission, `access publication views`, governs the admin listing; reader access is ordinary node access per page. Note `book:book` is a **contributed** project (Book left Drupal core after 10) so an 11 site must `composer require drupal/book`; the full LocalGov stack (`localgov_core`, `localgov_paragraphs` + its layout submodule, `pathauto`) is also required.

> Documented from source (1.1.5): `drush en localgov_publications` on bare Drupal fails with an unmet
> config dependency on `filter.format.wysiwyg`, a text format supplied by the LocalGov distribution.
> The module expects its distribution, not bare core.

---

- Publish a council strategy as HTML chapters.
- Replace a PDF annual report with web pages.
- Give a long document a contents page with next/previous navigation.
- Add jump links to headings inside a single-page publication.
- Make a formal document accessible and searchable in site search.
- Update one chapter without republishing the whole document.
- Re-order chapters and rename pages from an admin screen.
- Generate readable, hierarchy-aware chapter URLs with pathauto.
- Publish a local plan for public consultation.
- Meet public-sector accessibility obligations for documents.
- Offer an optional PDF download alongside the HTML version via a cover page.
- Group multiple versions of a document behind one cover page.
- Show a document's structure to readers with an outline block.
- Reuse LocalGov paragraph components inside chapters.
- Give publications a custom breadcrumb instead of the book-outline one.
- Restrict the administrative publications listing by permission.
- Migrate a PDF library to structured HTML.
- Preview an entire publication (all pages + cover) via a single preview link.
- Auto-anchor headings so a table-of-contents block can link to them.
- Provide a contents listing for a set of policies.
