<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PM dashboard & submodule framework

## Dashboard
`/pm` → `PmDashboardController::dashboard()` builds a render array themed `pm_dashboard`.
Links come from the `pm_dashboard_item` plugin manager (`plugin.manager.pm_dashboard_item`),
which discovers definitions from every enabled module's `MODULE.pm_dashboard_items.yml`.
Each item declares a `group`, a `link.path` and a label; the controller drops any item whose
`link.path` fails `PathValidator::isValid()` (so users only see links they can reach) and groups
the rest. Cache max-age is 0.

## Adding a dashboard item
Create `mymodule.pm_dashboard_items.yml`:
```yaml
my_item:
  label: 'My Tool'
  group: 'Work'
  link:
    path: '/my/tool'
```

## Per-project keys
`pm.pm_key` (`PmKey`) is keyvalue-backed (`pm_key` collection). `generateNextKey($prefix)`
increments and returns `PREFIX-N`. On presave of a `PmContentEntityBase` that has both
`pm_key` and `pm_project` fields, it assigns the next key using the project's `project_key`
unless the entity already carries a valid key.

## Entities & config
Work entities are provided by submodules, each a full content-entity type with its own
`*.permissions.yml`, action/task/menu links, Views and optional REST resource config.
Enable `pm_rest` to expose REST views; `pm_ui` provides an SDC pill formatter.
