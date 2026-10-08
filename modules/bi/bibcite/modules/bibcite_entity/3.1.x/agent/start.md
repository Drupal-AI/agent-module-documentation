<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - Entity (bibcite_entity) — agent index

The data model of the Bibcite suite. Defines three **content** entity types — `bibcite_reference`
(bundled by `bibcite_reference_type`), `bibcite_contributor`, `bibcite_keyword` — plus the config
entities and settings around them, and the `bibcite_link` plugin type.

- **Settings + config entities (reference/contributor settings, reference types, contributor
  roles/categories, CSL mapping)** → [configure/settings-and-types.md](configure/settings-and-types.md)
- **The three content entities: fields, creating them in code, normalizers, actions** →
  [api/entities.md](api/entities.md)
- **The `bibcite_link` plugin type (DOI / PubMed / Google Scholar) + how to add one** →
  [plugins/link.md](plugins/link.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts: configure route `bibcite_entity.reference.settings` (`/admin/config/bibcite/settings`
area). Global citekey pattern lives in `bibcite_entity.reference.settings:citekey.pattern`
(default `bibcite_[bibcite_reference:id]`). Reference types are `bibcite_reference_type` config
entities (book, journal_article, …). Contributor roles/categories are
`bibcite_contributor_role` / `bibcite_contributor_category` config entities. CSL conversion via
the `csl`-format `CslReferenceNormalizer` and `bibcite_entity.mapping.csl`.
