<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation - EndNote adds the **EndNote** import/export format to Bibcite, so bibcite Reference entities can be imported from and exported to EndNote files.

---

EndNote is a widely used reference manager; this supports EndNote 7 XML, EndNote X3 XML and the EndNote tagged (.enw) format. It is a thin "format handler" submodule: it declares one or more `bibcite_format`
plugins (ids: endnote7, endnote8, tagged) in `bibcite_endnote.bibcite_format.yml`, each pointing at the `EndnoteEncoder`
encoder/decoder class (implementing Symfony's Encoder and Decoder interfaces, so the format is
usable for **both import and export**), and ships a `bibcite_entity.mapping.endnote7` config that
maps EndNote record types and fields to Bibcite reference types and `bibcite_*` fields. A
service provider registers the encoder with the serializer, and a normalizer converts between the
EndNote structure and Reference entities. Once enabled, the format appears automatically in the
Bibcite import form, the export links/actions, and the format plugin manager — the module itself
has no configuration UI, permissions, routes or Drush of its own.

---

- Import a EndNote file of references into Bibcite.
- Export bibcite references to a EndNote file for use elsewhere.
- Offer a per-reference "EndNote" download link on a rendered citation.
- Bulk-export selected references in EndNote via the export actions.
- Round-trip references out to EndNote and back into another Bibcite site.
- Map EndNote record types to the matching Bibcite reference types.
- Map EndNote fields onto Bibcite `bibcite_*` fields via the mapping config.
- Add EndNote as one of several interchange formats available on a bibliography.
- Let researchers submit references as EndNote files.
- Migrate an existing EndNote bibliography into Drupal.
- Provide EndNote export for integration with external reference tools.
- Enable/disable EndNote support simply by enabling/uninstalling this submodule.
- Decode uploaded EndNote files (extension: xml/enw) during batch import.
- Encode a reference to EndNote on demand through the export route.
- Customise the EndNote type mapping by editing `bibcite_entity.mapping.endnote7`.
- Support citation portability between EndNote-speaking systems.
- Expose EndNote in the `bibcite_format` plugin list for programmatic use.
- Combine with other format submodules to offer several export choices.
- Keep the Bibcite core install lean by only enabling the formats you need.
