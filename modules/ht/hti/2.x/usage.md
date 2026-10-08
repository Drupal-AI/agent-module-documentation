<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hierarchical Taxonomy Importer (machine name `hierarchical_taxonomy_importer`) imports taxonomy terms in a nested parent-child structure into a chosen vocabulary from an uploaded CSV file.

---

Building a large hierarchical vocabulary term-by-term in the UI is slow and error-prone. Hierarchical Taxonomy Importer adds an admin form (Configuration → Development → Taxonomy Importer) where a site builder picks a target vocabulary, uploads a CSV whose columns represent hierarchy depth (column 1 = root level, each further column one level deeper), and the module creates the terms with their parent references in a single submit. Empty leading cells in a row indicate the term sits under the parent established by earlier rows, so an indented spreadsheet layout maps directly onto the term tree. It reads CSV only (the upload is checked for a `.csv` extension and parsed with PHP's `fgetcsv`); despite the "csv/Excel" phrasing elsewhere, spreadsheet binary formats such as `.xlsx` are not parsed. The importer only creates new terms — it does not update or de-duplicate against the existing tree — so it is best run on an empty or freshly built vocabulary, after validating the source file, ideally with a backup in place. It is a controlled site-building tool gated by the core `administer taxonomy` permission.

---

- Bulk-load a deep taxonomy hierarchy from a spreadsheet instead of adding terms one at a time.
- Populate a new, empty vocabulary with hundreds of nested terms in one operation.
- Import a product-category tree (e.g. Electronics → Computers → Laptops → Gaming Laptops) preserving parent-child links.
- Seed a fresh site's vocabularies during initial site building from a prepared CSV.
- Recreate a taxonomy structure exported from another system as a CSV.
- Stand up a geographic hierarchy (Country → Region → City) as taxonomy terms.
- Build an organisational-unit tree (Division → Department → Team) for content tagging.
- Convert a column-indented spreadsheet outline directly into a term tree.
- Onboard editors by pre-building the tagging vocabulary they will use.
- Quickly prototype a vocabulary structure for a content model, then refine in the UI.
- Import a multi-level menu-like classification for filtering or faceted browsing.
- Load a reference taxonomy (industry codes, subject headings) supplied as CSV.
- Migrate a small legacy category list into Drupal taxonomy without writing a Migrate pipeline.
- Rebuild a vocabulary from a versioned CSV kept in your repository.
- Give a chosen vocabulary its full nesting in one submit rather than setting each term's parent manually.
- Provide a repeatable way to reconstruct a demo vocabulary across environments.
- Populate a vocabulary used by Views term-hierarchy filters or menu generation.
- Set up nested terms that later drive breadcrumbs, faceted search, or content organisation.
- Import terms whose depth is expressed by the column position in each CSV row.
- Restrict the import operation to taxonomy administrators via the `administer taxonomy` permission.
