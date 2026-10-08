<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Parameters UI (eca_parameters_ui) — agent index

Optional submodule of **eca_parameters**. Adds a web admin screen to manage the `eca` parameters
collection that ECA models read/write. Package **ECA**. Core `^10.3 || ^11`. GPL-2.0-or-later.
Version 2.0.2.

- **Depends on:** `eca:eca_parameters`, `eca:eca_ui (^2)`, `parameters:parameters_ui`.
- **No PHP** — it only supplies a route, a permission and a menu task that reuse `parameters_ui`'s
  controller. No services, no config, no schema, no Drush.
- Parent project: `eca_parameters` → `../../../2.0.x/agent/start.md`.

## What it provides

- **Route** `entity.eca.parameters` (`eca_parameters_ui.routing.yml`):
  `/admin/config/workflow/eca/parameters` → `parameters_ui`'s
  `ParametersUiController::parametersCollectionForm` (title
  `::parametersCollectionTitle`), with `parameters_collection_id: eca`, option
  `_parameters_ui: true`, guarded by `_permission: 'administer eca parameters'`.
- **Permission** `administer eca parameters` (`eca_parameters_ui.permissions.yml`,
  `restrict access: true`).
- **Local task** `entity.eca.parameters` "Parameters" (weight 150), base route
  `entity.eca.collection` — a tab in the ECA admin area at `/admin/config/workflow/eca`.

## How to operate

Enable it (`drush en eca_parameters_ui -y`), grant `administer eca parameters` to a trusted role,
then manage the ECA collection's parameters at `/admin/config/workflow/eca/parameters`. See
[config/ui.md](config/ui.md).
