<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Unpublished Terms (better_unpublished_terms) — agent index

Broadens who may **view and reference unpublished taxonomy terms**: users with `create`/`edit`/`delete terms in <vocab>`
gain view + reference access to that vocabulary's unpublished terms (core normally limits this to `administer taxonomy`).
Published terms still need only `access content`. Drop-in, **no config, no permissions of its own**.

- Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-beta2.
- Dependencies: core `taxonomy`, contrib `inline_entity_form` (the IEF use case is the reason it exists).
- **No** routes, services, config objects, schema, Drush commands, or hook_install. Two hooks + two classes only.

## What it actually provides

- **Access handler swap** — `better_unpublished_terms_entity_type_alter()` (in `better_unpublished_terms.module`)
  sets the `taxonomy_term` `access` handler to `BetterTermAccessControlHandler`.
- **Reference selection swap** — `better_unpublished_terms_entity_reference_selection_alter()` overrides the
  `default:taxonomy_term` selection plugin `class` with `BetterUnpublishedTermSelection`.

## How it works & the exact access rule → [access/term-access.md](access/term-access.md)

- `src/BetterTermAccessControlHandler.php` extends core `TermAccessControlHandler`; overrides `checkAccess()` for the
  `view` operation, delegates all other operations to parent.
- `src/Plugin/EntityReferenceSelection/BetterUnpublishedTermSelection.php` extends core `TermSelection`; overrides
  `buildEntityQuery()` (adds `status = 1` unless the user may see unpublished) and `validateReferenceableNewEntities()`.

## Notes

- No `*.permissions.yml`, `*.routing.yml`, `*.services.yml`, `*.links.*.yml`, `*.install`, or `config/` ship with the
  module. `data.json` `provides_config_schema` is **false**.
- The bundled test `tests/src/Functional/BetterUnpublishedTermsTest.php` is an empty stub (no real coverage).
