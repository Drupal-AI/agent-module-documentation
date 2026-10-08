<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate CiviCRM provides a migrate **source** and **destination** plugin backed by the CiviCRM API v4 service, letting you read from and write to CiviCRM entities inside a Drupal migration.
---
The module wires two migrate plugins to the `@civicrm` service via an `Api4Iterator`: a source plugin (`CiviCrmApi4`) that iterates records returned by a CiviCRM API v4 `get`, and a destination plugin (`CiviCrmApi4`) that creates/updates CiviCRM records; a `NoOp` destination is also included. Because it talks to the CiviCRM API layer rather than the raw database, entity access and CiviCRM business logic are respected by the API.

It requires a working CiviCRM installation (the `civicrm` service must exist) plus core Migrate; migrations are defined as normal migrate YAML using the provided source/destination plugin ids. There are no routes, permissions, forms or config — it is a developer/CLI (`drush migrate:*`) tool. Setup: define a migration whose `source` uses the CiviCRM API v4 source and/or whose `destination` uses the API v4 destination, then run it with Migrate Tools/Drush.
---
- Import CiviCRM contacts into Drupal entities via a migration.
- Read CiviCRM API v4 entities as a migrate source.
- Write records to CiviCRM as a migrate destination.
- Sync CiviCRM activities into Drupal content.
- Migrate CiviCRM contributions into Commerce/entities.
- Use a NoOp destination for dry-run/lookup-only migrations.
- Iterate large CiviCRM result sets with the API4 iterator.
- Respect CiviCRM API business logic during import/export.
- Run migrations from the CLI with `drush migrate:import`.
- Roll back CiviCRM-sourced migrations with `drush migrate:rollback`.
- Map CiviCRM fields to Drupal fields in a migration process pipeline.
- Push updated Drupal data back into CiviCRM records.
- Combine with migrate_plus for config-entity migrations.
- Stage a CiviCRM-to-Drupal data integration.
- Migrate CiviCRM custom fields via API v4.
- Feed CiviCRM data into a Search API index through a migration.
