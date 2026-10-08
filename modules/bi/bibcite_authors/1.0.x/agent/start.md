<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibcite Authors (bibcite_authors) — agent index

Provides three field formatters for the `bibcite_contributor` field type (Bibcite's author/contributor
reference). They render Contributor names last-name-first and optionally link each name to a Drupal user
account that references the Contributor via a `field_author` field. Version **1.0.6**;
core `^8.8.0 || ^9.0 || ^10 || ^11`.

- Depends on: `bibcite` project (Contributor entity comes from its `bibcite_entity` submodule).
- No config schema, no settings route, no routes, no permissions, no services, no hooks.
- Used purely by selecting a formatter on a reference entity's Manage Display page (or in a view).

## Provides

Three `@FieldFormatter` plugins in `src/Plugin/Field/FieldFormatter/`, all for
`field_types = { "bibcite_contributor" }`:

- `bibcite_authors_last_name_first` — `LastNameFirst.php`: "Authors (Last name first)". Plain
  `Last, First Middle`, no linking.
- `bibcite_authors_last_name_with_link` — `LastNameWithLink.php`: "Authors (Last name first with link to
  user)". `Last, First Middle`, wrapped in a `/user/{uid}` link when an account references the Contributor.
- `bibcite_authors_authors_with_link_to_user` — `LinkToUser.php`: "Authors (with link to user)".
  `First Middle Last`; when a linked account exists, links to it and shows the user's `field_name`.

## Solution docs

- [Field formatters](fields/formatters.md) — the three formatters, name assembly, user lookup, install/use.
