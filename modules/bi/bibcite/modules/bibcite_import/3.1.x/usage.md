<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation - Import imports bibcite Reference entities from uploaded files in any registered format (BibTeX, RIS, EndNote, MARC), with a batch import UI and controls to deduplicate contributors and keywords on import.

---

The submodule adds import capability on top of `bibcite_entity`, decoding uploaded files via the
`bibcite_format` plugins whose encoder implements Symfony's `DecoderInterface`. The **import form**
(`/admin/content/bibcite/reference/import`, `ImportForm`, permission `bibcite import`+`administer
bibcite`) lets a user upload a file, choose its format, and batch-create reference entities from
it. A **populate form** (`/admin/content/bibcite/reference/populate`, permission `bibcite
populate`+`administer bibcite`) re-populates/normalizes reference field values. A settings form
(`/admin/config/bibcite/settings/import`, permission `administer bibcite`) edits the
`bibcite_import.settings` config object, which has two booleans under `settings`:
`contributor_deduplication` and `keyword_deduplication` (both default `true`) — when on, imported
authors/keywords are matched to existing Contributor/Keyword entities instead of creating
duplicates. Import runs as a Drupal batch (`bibcite_import.batch.inc`). It ships two permissions,
`bibcite import` and `bibcite populate` (both restricted).

---

- Import a BibTeX `.bib` file exported from a reference manager into the site.
- Bulk-load references from an RIS file (Zotero/Mendeley/EndNote export).
- Import EndNote XML or tagged files of references.
- Import a MARC file from a library catalog.
- Deduplicate authors on import so repeated contributors aren't duplicated.
- Deduplicate keywords on import to keep a clean keyword vocabulary.
- Disable contributor deduplication to keep every imported author record distinct.
- Batch-import a large bibliography without timing out.
- Migrate an existing bibliography into Bibcite from a standard file format.
- Re-populate reference field values via the populate form after a mapping change.
- Restrict import to trusted users with the `bibcite import` permission.
- Restrict the populate operation with the `bibcite populate` permission.
- Choose the source format explicitly when uploading a file.
- Seed a demo site with a set of sample references from a file.
- Import references contributed by researchers in their preferred format.
- Keep contributor identities consistent across many imported references.
- Load conference proceedings or journal article lists in bulk.
- Combine with the format submodules to control which import formats are offered.
- Configure deduplication behavior globally via bibcite_import.settings.
- Round-trip references out (bibcite_export) and back in (bibcite_import) between sites.
