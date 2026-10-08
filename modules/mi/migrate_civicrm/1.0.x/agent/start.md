<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate CiviCRM (migrate_civicrm) — agent index

**Migrate source and destination plugins for CiviCRM API v4.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10 || ^11
- **Depends:** migrate (requires a working CiviCRM install / `@civicrm` service)
- **Plugins:** source `CiviCrmApi4`, destination `CiviCrmApi4`, destination `NoOp`; helper `Api4Iterator`.
- **Services:** `civicrm_migrate_dest.destination.api4`, `migrate_civicrm.api4_iterator`.
- **Security:** developer/CLI migration tool; no routes, permissions, forms or config; goes through the CiviCRM API layer (business logic/access enforced by CiviCRM).

See [api/plugins.md](api/plugins.md).
