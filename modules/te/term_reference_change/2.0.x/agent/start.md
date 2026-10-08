<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term Reference Change — agent index

API-only module. **No UI, no routes, no permissions, no config, no plugins, no Drush,
no config schema.** `configure` is `null`. Depends only on core `taxonomy`.

Everything it does is behind two services:

| Service ID | Class | Purpose |
|---|---|---|
| `term_reference_change.reference_finder` | `Drupal\term_reference_change\ReferenceFinder` | discover term reference fields + entities referencing a term |
| `term_reference_change.migrator` | `Drupal\term_reference_change\ReferenceMigrator` | rewrite references from one term to another and save |

- **Call the services: signatures, return shapes, `$limit` semantics, gotchas** →
  [api/services.md](api/services.md)

Key fact: `ReferenceMigrator::migrateReference($source, $target, $limit = [])` mutates and
`save()`s each referencing entity directly. There is no batch, no queue, no dry run, and
the source term is **not** deleted.
