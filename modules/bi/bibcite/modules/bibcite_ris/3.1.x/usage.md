<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation - RIS adds the **RIS** import/export format to Bibcite, so bibcite Reference entities can be imported from and exported to RIS files.

---

RIS is a tagged interchange format supported by Zotero, Mendeley, EndNote and others. It is a thin "format handler" submodule: it declares one or more `bibcite_format`
plugins (ids: ris) in `bibcite_ris.bibcite_format.yml`, each pointing at the `RISEncoder`
encoder/decoder class (implementing Symfony's Encoder and Decoder interfaces, so the format is
usable for **both import and export**), and ships a `bibcite_entity.mapping.ris` config that
maps RIS record types and fields to Bibcite reference types and `bibcite_*` fields. A
service provider registers the encoder with the serializer, and a normalizer converts between the
RIS structure and Reference entities. Once enabled, the format appears automatically in the
Bibcite import form, the export links/actions, and the format plugin manager — the module itself
has no configuration UI, permissions, routes or Drush of its own.

---

- Import a RIS file of references into Bibcite.
- Export bibcite references to a RIS file for use elsewhere.
- Offer a per-reference "RIS" download link on a rendered citation.
- Bulk-export selected references in RIS via the export actions.
- Round-trip references out to RIS and back into another Bibcite site.
- Map RIS record types to the matching Bibcite reference types.
- Map RIS fields onto Bibcite `bibcite_*` fields via the mapping config.
- Add RIS as one of several interchange formats available on a bibliography.
- Let researchers submit references as RIS files.
- Migrate an existing RIS bibliography into Drupal.
- Provide RIS export for integration with external reference tools.
- Enable/disable RIS support simply by enabling/uninstalling this submodule.
- Decode uploaded RIS files (extension: ris) during batch import.
- Encode a reference to RIS on demand through the export route.
- Customise the RIS type mapping by editing `bibcite_entity.mapping.ris`.
- Support citation portability between RIS-speaking systems.
- Expose RIS in the `bibcite_format` plugin list for programmatic use.
- Combine with other format submodules to offer several export choices.
- Keep the Bibcite core install lean by only enabling the formats you need.
