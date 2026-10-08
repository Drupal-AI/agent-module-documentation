<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation - Marc adds the **Marc** import/export format to Bibcite, so bibcite Reference entities can be imported from and exported to Marc files.

---

MARC is the machine-readable cataloging format used by libraries. It is a thin "format handler" submodule: it declares one or more `bibcite_format`
plugins (ids: marc) in `bibcite_marc.bibcite_format.yml`, each pointing at the `MarcEncoder`
encoder/decoder class (implementing Symfony's Encoder and Decoder interfaces, so the format is
usable for **both import and export**), and ships a `bibcite_entity.mapping.marc` config that
maps Marc record types and fields to Bibcite reference types and `bibcite_*` fields. A
service provider registers the encoder with the serializer, and a normalizer converts between the
Marc structure and Reference entities. Once enabled, the format appears automatically in the
Bibcite import form, the export links/actions, and the format plugin manager — the module itself
has no configuration UI, permissions, routes or Drush of its own.

---

- Import a Marc file of references into Bibcite.
- Export bibcite references to a Marc file for use elsewhere.
- Offer a per-reference "Marc" download link on a rendered citation.
- Bulk-export selected references in Marc via the export actions.
- Round-trip references out to Marc and back into another Bibcite site.
- Map Marc record types to the matching Bibcite reference types.
- Map Marc fields onto Bibcite `bibcite_*` fields via the mapping config.
- Add Marc as one of several interchange formats available on a bibliography.
- Let researchers submit references as Marc files.
- Migrate an existing Marc bibliography into Drupal.
- Provide Marc export for integration with external reference tools.
- Enable/disable Marc support simply by enabling/uninstalling this submodule.
- Decode uploaded Marc files (extension: mrc) during batch import.
- Encode a reference to Marc on demand through the export route.
- Customise the Marc type mapping by editing `bibcite_entity.mapping.marc`.
- Support citation portability between Marc-speaking systems.
- Expose Marc in the `bibcite_format` plugin list for programmatic use.
- Combine with other format submodules to offer several export choices.
- Keep the Bibcite core install lean by only enabling the formats you need.
