<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Metatag: Google Scholar adds the Highwire Press "citation_*" meta tags to Metatag so scholarly articles (journal papers, dissertations, technical reports) can be indexed by Google Scholar.

---

A thin extension of the [Metatag](https://www.drupal.org/project/metatag) module: it defines one Metatag group, **Google Scholar** (`google_scholar`), and 14 Metatag tag plugins for the Highwire Press citation meta tags Google Scholar reads. There is no settings form of its own (`configure` is null) and no permissions — you configure the tags through Metatag's normal defaults (`/admin/config/search/metatag`) or per-entity Metatag fields, where a new "Google Scholar" section appears. Each tag renders as `<meta name="citation_…" content="…">`. The tag plugin classes are near-empty subclasses of Metatag's `MetaNameBase`; all behaviour (token replacement, rendering, per-entity overrides) comes from Metatag core. Values support tokens, so tags can be mapped to entity fields (author, publication date, ISSN, PDF URL, etc.).

---

- Expose journal-article nodes to Google Scholar indexing with citation meta tags.
- Set `citation_title` from the node title via a token in Metatag defaults.
- Add one or more `citation_author` tags (multiple allowed) for a paper's authors.
- Provide `citation_publication_date` from a date field.
- Emit `citation_journal_title` for articles published in a journal.
- Add `citation_issn` / `citation_isbn` identifiers.
- Set `citation_volume`, `citation_issue`, `citation_firstpage`, `citation_lastpage` for an article's location.
- Point Google Scholar at the full text with `citation_pdf_url`.
- Tag dissertations with `citation_dissertation_institution`.
- Tag technical reports with `citation_technical_report_institution` and `citation_technical_report_number`.
- Configure Google Scholar tags globally per content type using Metatag defaults.
- Override citation tags per node via a Metatag field.
- Map citation tags to custom fields with Metatag tokens.
- Improve academic/repository sites' discoverability in Google Scholar.
- Combine with other Metatag submodules (Open Graph, Dublin Core) on the same entities.
- Provide machine-readable bibliographic metadata for citation managers that read Highwire tags.
