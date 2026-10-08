<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - BibTeX (bibcite_bibtex) — agent index

Adds the **BibTeX** import/export format to Bibcite by declaring `bibcite_format` plugin(s)
(bibtex) backed by the `BibtexEncoder` encoder, plus a `bibcite_entity.mapping.bibtex` type/field map.
No config UI, permissions, routes or Drush of its own.

- **The format plugin(s), encoder, extension, and the type/field mapping** →
  [api/format.md](api/format.md)

Key facts: plugin ids **bibtex** (from `bibcite_bibtex.bibcite_format.yml`), extension **bib**, encoder
`\Drupal\bibcite_bibtex\Encoder\BibtexEncoder` (Encoder+Decoder → usable for both import and export). The BibTeX→Bibcite type/field
mapping lives in the config object `bibcite_entity.mapping.bibtex`. Enabling the submodule makes
the format appear in the import form, export links/actions, and the `bibcite_format` manager.
