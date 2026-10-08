# Entity Definition Update — manual setup guide

**Entity Definition Update** (`entity_definition_update`) is a **developer tool** for
applying entity‑type and field definition changes to your database in a safe,
deploy‑friendly way — through ordinary `hook_update_N()` update hooks rather than by
clicking a button in the UI or running ad‑hoc code. It's an alternative to core's
*Entity Type Definition Update Manager*.

The typical situation is the familiar "mismatched entity/field definitions" state:
you've changed an entity type or field in code, and the storage schema in the
database needs to catch up. This module gives you a service you call from an update
hook so the reconciliation happens as part of your normal update path
(`drush updatedb` / the update pipeline), where it can be reviewed, deployed, and
rolled out consistently across environments.

For a brand‑new field with no existing data, applying updates is straightforward —
call the update manager's `applyUpdates()` from `hook_install()` or an update hook:

```php
$entityDefinitionUpdate = \Drupal::service('entity_definition_update.entity_definition_update_manager');
$entityDefinitionUpdate->applyUpdates();
```

When existing fields already hold data that you need to preserve, the change is more
involved: the documented pattern backs the data up to a temporary table, truncates
the original, applies the definition update, and then restores the data into the
updated structure. **Applying definition updates changes storage**, so treat it with
the same care as any migration: **back up your database first, run it through the
normal update pipeline, and always test in a non‑production environment before
deploying.** It depends on core **System** and **Field**, and exposes no public
route (it operates entirely in the already‑privileged update/deploy context).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module so its service is available to your update hooks.

There is **no configuration page** — this is a code‑facing developer tool used from
`hook_update_N()` / `hook_install()`, not the admin UI.

## How to use it

Enable the module, then from an update or install hook call the
`entity_definition_update.entity_definition_update_manager` service's
`applyUpdates()` method. Run your updates with `drush updatedb` as part of your
deployment. For entity types with existing data, follow the backup‑truncate‑update‑
restore pattern described in the project documentation, and always test on a copy of
production data first.
