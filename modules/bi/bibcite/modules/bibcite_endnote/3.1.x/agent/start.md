<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - EndNote (bibcite_endnote) — agent index

Adds the **EndNote** import/export format to Bibcite by declaring `bibcite_format` plugin(s)
(endnote7, endnote8, tagged) backed by the `EndnoteEncoder` encoder, plus a `bibcite_entity.mapping.endnote7` type/field map.
No config UI, permissions, routes or Drush of its own.

- **The format plugin(s), encoder, extension, and the type/field mapping** →
  [api/format.md](api/format.md)

Key facts: plugin ids **endnote7, endnote8, tagged** (from `bibcite_endnote.bibcite_format.yml`), extension **xml/enw**, encoder
`\Drupal\bibcite_endnote\Encoder\EndnoteEncoder` (Encoder+Decoder → usable for both import and export). The EndNote→Bibcite type/field
mapping lives in the config object `bibcite_entity.mapping.endnote7`. Enabling the submodule makes
the format appear in the import form, export links/actions, and the `bibcite_format` manager.
