<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation - Entity is the data model of the Bibcite suite: it stores bibliographic records as Drupal content entities — **Reference** (bundled by reference type), **Contributor** (authors/editors), and **Keyword** — which can be rendered as citations, exported and imported.

---

The submodule defines three content entity types and their configuration. **`bibcite_reference`**
is a revisionable, publishable content entity bundled by the **`bibcite_reference_type`** config
entity (~40 shipped types: book, journal_article, thesis, patent, …), each type declaring which
`bibcite_*` fields are shown/required and a citekey pattern. **`bibcite_contributor`** stores
person/organization names (parsed into prefix/first/last/suffix), categorised by
**`bibcite_contributor_category`** and **`bibcite_contributor_role`** config entities (author,
editor, translator, …). **`bibcite_keyword`** stores subject keywords. Two settings objects tune
behavior: `bibcite_entity.reference.settings` (UI form override, reference page view mode, and the
global `citekey.pattern`, default `bibcite_[bibcite_reference:id]`) and
`bibcite_entity.contributor.settings` (the `full_name_pattern`). A `bibcite_entity.mapping.csl`
config plus a `CslReferenceNormalizer` (serialization format `csl`) convert a Reference to/from
CSL-JSON so bibcite core can render it. It defines the **`bibcite_link`** plugin type
(`Plugin/bibcite/link`, manager `plugin.manager.bibcite_link`) with shipped link plugins DOI,
Google Scholar, PubMed and PubMed Central that add external links to a rendered reference. It also
ships bulk **actions** (save/delete/merge/regenerate citekey for references, contributors,
keywords), entity-reference selection plugins, a contributor field type/widget, Views
integration, and a full permission set (create/edit/delete/view per entity plus administer).

---

- Store a library of bibliographic references as first-class Drupal entities.
- Create references of a specific type (book, journal article, thesis, conference paper, …).
- Define or customise reference types and which fields each requires.
- Set the global citation-key (citekey) pattern used to identify references.
- Store authors/editors as reusable Contributor entities shared across references.
- Assign contributor roles (author, editor, translator) and categories to a reference's people.
- Deduplicate and merge duplicate contributors or keywords via the merge actions.
- Tag references with reusable Keyword entities for faceting and browsing.
- Render a reference as a citation by normalizing it to CSL-JSON for bibcite core.
- Add DOI, PubMed, PubMed Central and Google Scholar links to a rendered reference.
- Regenerate citation keys in bulk with the "regenerate citekey" action.
- Bulk-delete or bulk-save references, contributors or keywords from an admin view.
- Reference contributors/keywords from other entities via the provided selection plugins.
- Build a bibliography listing view of references (admin views are provided).
- Control the view mode used on the reference page (e.g. table vs citation).
- Override the reference edit form globally via the form-override setting.
- Provide granular access with per-entity create/edit/delete/view permissions.
- Store abstracts, ISBN/ISSN/DOI, volume, pages and dozens of other bibliographic fields.
- Import/export references (with the import/export/format submodules) using this data model.
- Expose references in Views with citation and links field handlers.
- Extend link behavior by adding a custom `bibcite_link` plugin.
