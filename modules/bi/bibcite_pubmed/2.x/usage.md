Import bibliographic references into Drupal from the PubMed/NCBI database, either one PubMed ID at a time through an admin lookup form or in bulk via the bibcite import pipeline.

---

Bibliography & Citation - PubMed extends the Bibliography & Citation (bibcite) suite with a PubMed/NCBI integration. It registers two serializer formats — `pubmed` (the XML returned by NCBI's E-utilities `efetch` endpoint) and `pubmed_id` (a plain list of PubMed IDs, one per line) — and a `PubmedClient` service that fetches article metadata from `https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi`. The included `PubmedEncoder` parses the PubMed XML into an array of article field values (title, authors, keywords, abstract, journal, year, volume, issue, pagination, ISSN, DOI, PMID, PMCID, and more); the `PubmedReferenceNormalizer` turns those values into a `bibcite_entity` Reference entity, applying the configurable type and field mapping shipped in `config/install/bibcite_entity.mapping.pubmed.yml`. A `PubMed lookup` form under the reference collection lets an administrator paste a single PMID, previews the resulting reference in the private tempstore, and redirects to the reference add form pre-populated with the fetched metadata. Access to the lookup form requires the `administer bibcite` permission. The module has no settings page of its own; behaviour is driven by the bibcite mapping config and (for deduplication) the optional `bibcite_import` module's settings.

---

- Import a single reference by pasting its PubMed ID into the PubMed lookup form at `/admin/content/bibcite/reference/pmlookup`.
- Pre-populate the reference add form with PubMed metadata, then review and edit before saving.
- Bulk-import many references by supplying a newline-separated list of PubMed IDs through the bibcite import format `pubmed_id`.
- Import raw PubMed `efetch` XML directly using the `pubmed` serializer format.
- Automatically map PubMed publication types (Journal Article, Review, Clinical Trial, Editorial, Letter, etc.) to bibcite reference types via `bibcite_entity.mapping.pubmed`.
- Capture article titles and author lists (including corporate/collective authors) from PubMed into structured contributor fields.
- Pull abstracts — including labelled/structured abstract sections — into a reference's abstract field.
- Store the DOI, ISSN, ISO journal abbreviation, PMID, and PMC ID of each imported article.
- Record journal title, volume, issue, pagination, publication year, and publication date.
- Build a canonical PubMed URL (`https://www.ncbi.nlm.nih.gov/pubmed/{PMID}`) for each imported reference.
- Batch large PMID lists automatically — the `pubmed_id` decoder chunks IDs into groups of 50 per API request.
- Combine multiple PubMed IDs in one lookup by passing a comma-joined or array PMID to the client's `fetch()` method.
- Keep an existing bibliography in sync with PubMed by re-importing updated records.
- Respect contributor and keyword deduplication settings from `bibcite_import` when creating references.
- Seed a research group's publication list from a curated set of PubMed IDs.
- Populate a library or institutional repository with medical/life-sciences citations sourced from NCBI.
- Provide a quick "add from PubMed" action link on the reference collection page for editors.
- Extend or override the field/type mapping to fit a custom bibcite reference-type setup.
- Reuse the `PubmedClient` service in custom code to fetch PubMed XML for further processing.
- Add the PMC ID to references so full-text links to PubMed Central can be derived.
- Normalise author names from PubMed's ForeName/LastName/Initials/CollectiveName variants into a single display name.
- Serve as a formats plugin within a larger bibcite deployment alongside other importers (BibTeX, RIS, etc.).
