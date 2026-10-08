<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - RIS (bibcite_ris) — agent index

Adds the **RIS** import/export format to Bibcite by declaring `bibcite_format` plugin(s)
(ris) backed by the `RISEncoder` encoder, plus a `bibcite_entity.mapping.ris` type/field map.
No config UI, permissions, routes or Drush of its own.

- **The format plugin(s), encoder, extension, and the type/field mapping** →
  [api/format.md](api/format.md)

Key facts: plugin ids **ris** (from `bibcite_ris.bibcite_format.yml`), extension **ris**, encoder
`\Drupal\bibcite_ris\Encoder\RISEncoder` (Encoder+Decoder → usable for both import and export). The RIS→Bibcite type/field
mapping lives in the config object `bibcite_entity.mapping.ris`. Enabling the submodule makes
the format appear in the import form, export links/actions, and the `bibcite_format` manager.
