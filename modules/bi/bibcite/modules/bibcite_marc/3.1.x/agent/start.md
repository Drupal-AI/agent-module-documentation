<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - Marc (bibcite_marc) — agent index

Adds the **Marc** import/export format to Bibcite by declaring `bibcite_format` plugin(s)
(marc) backed by the `MarcEncoder` encoder, plus a `bibcite_entity.mapping.marc` type/field map.
No config UI, permissions, routes or Drush of its own.

- **The format plugin(s), encoder, extension, and the type/field mapping** →
  [api/format.md](api/format.md)

Key facts: plugin ids **marc** (from `bibcite_marc.bibcite_format.yml`), extension **mrc**, encoder
`\Drupal\bibcite_marc\Encoder\MarcEncoder` (Encoder+Decoder → usable for both import and export). The Marc→Bibcite type/field
mapping lives in the config object `bibcite_entity.mapping.marc`. Enabling the submodule makes
the format appear in the import form, export links/actions, and the `bibcite_format` manager.
