Adds DOI-based lookup and bulk import to Bibliography & Citation (Bibcite), fetching reference metadata from the Crossref REST API and mapping it onto Bibcite reference entities.

---

Bibcite Crossref extends the Bibliography & Citation suite with a Crossref integration. A "DOI lookup" form on the reference collection page lets an editor paste a single DOI, fetch its metadata from `https://api.crossref.org`, and land on a pre-populated reference-add form. A second serialization format, `crossref_doi`, plugs into Bibcite's import pipeline so a newline-separated list of DOIs can be imported in one batch, each DOI resolved through Crossref. The module ships the encoders, normalizers and field/type mappings that translate Crossref's JSON into Bibcite reference fields (title, authors and their roles, subjects/keywords, abstract, publication year, ISSN/ISBN, pages, publisher, DOI, links, etc.). A configurable contact email ("mailto") is passed with each query to place requests in Crossref's polite pool, and the client throttles itself to stay under Crossref's published rate limits. All functionality is gated behind the `administer bibcite` permission.

---

- Populate a new reference by pasting a single DOI on the "DOI lookup" form at `/admin/content/bibcite/reference/lookup`.
- Auto-fill a reference-add form (title, authors, journal, year, pages) from Crossref instead of typing metadata by hand.
- Bulk-import many references at once by feeding a newline-separated list of DOIs through Bibcite's import UI using the "Crossref DOI" format.
- Correctly map Crossref work types (journal-article, book-chapter, proceedings, dataset, report, etc.) onto Bibcite reference bundles.
- Import author, editor, chair and translator contributors, preserving each contributor's role on the reference.
- Capture institutional/organizational authors (Crossref entries with a `name` but no family/given) without dropping them.
- Store contributor affiliations from Crossref onto the contributor's suffix field.
- Clean Crossref JATS-XML abstracts into plain text before storing them, so markup does not render literally.
- Record subjects returned by Crossref as Bibcite keywords.
- Keep the DOI, ISSN, ISBN, publisher, volume, issue, pages and container title in sync with the canonical Crossref record.
- Configure a Crossref contact email at `/admin/config/bibcite/crossref` to join Crossref's "polite pool" and get a higher request rate.
- Get a status-report warning reminding you to set the contact email when it is missing.
- Respect Bibcite Import's contributor and keyword deduplication settings during a DOI lookup, when `bibcite_import` is enabled.
- Report per-DOI fetch failures during a batch import instead of silently dropping unreachable DOIs.
- Stay within Crossref's rate limits automatically (5 req/s anonymous, 10 req/s with a mailto) via built-in request throttling.
- Build a bibliography quickly by importing DOIs harvested from a reading list or reference manager.
- Standardize citation metadata across an editorial team by always sourcing it from Crossref.
- Seed a research or library site's reference collection from a curated DOI list.
- Extend or override the mapping by editing the `bibcite_entity.mapping.crossref` / `crossref_doi` config so a field maps to a different Bibcite field.
