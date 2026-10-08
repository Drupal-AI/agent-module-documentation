<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation - BibTeX adds the **BibTeX** import/export format to Bibcite, so bibcite Reference entities can be imported from and exported to BibTeX files.

---

BibTeX is the reference format used with LaTeX/BibTeX. It is a thin "format handler" submodule: it declares one or more `bibcite_format`
plugins (ids: bibtex) in `bibcite_bibtex.bibcite_format.yml`, each pointing at the `BibtexEncoder`
encoder/decoder class (implementing Symfony's Encoder and Decoder interfaces, so the format is
usable for **both import and export**), and ships a `bibcite_entity.mapping.bibtex` config that
maps BibTeX record types and fields to Bibcite reference types and `bibcite_*` fields. A
service provider registers the encoder with the serializer, and a normalizer converts between the
BibTeX structure and Reference entities. Once enabled, the format appears automatically in the
Bibcite import form, the export links/actions, and the format plugin manager — the module itself
has no configuration UI, permissions, routes or Drush of its own.

---

- Import a BibTeX file of references into Bibcite.
- Export bibcite references to a BibTeX file for use elsewhere.
- Offer a per-reference "BibTeX" download link on a rendered citation.
- Bulk-export selected references in BibTeX via the export actions.
- Round-trip references out to BibTeX and back into another Bibcite site.
- Map BibTeX record types to the matching Bibcite reference types.
- Map BibTeX fields onto Bibcite `bibcite_*` fields via the mapping config.
- Add BibTeX as one of several interchange formats available on a bibliography.
- Let researchers submit references as BibTeX files.
- Migrate an existing BibTeX bibliography into Drupal.
- Provide BibTeX export for integration with external reference tools.
- Enable/disable BibTeX support simply by enabling/uninstalling this submodule.
- Decode uploaded BibTeX files (extension: bib) during batch import.
- Encode a reference to BibTeX on demand through the export route.
- Customise the BibTeX type mapping by editing `bibcite_entity.mapping.bibtex`.
- Support citation portability between BibTeX-speaking systems.
- Expose BibTeX in the `bibcite_format` plugin list for programmatic use.
- Combine with other format submodules to offer several export choices.
- Keep the Bibcite core install lean by only enabling the formats you need.
