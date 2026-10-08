<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Parameters UI — route, permission, task

## Install & enable

```bash
drush en eca_parameters_ui -y
```

Dependencies (`eca_parameters_ui.info.yml`): `eca:eca_parameters`, `eca:eca_ui (^2)`,
`parameters:parameters_ui`. Enabling this submodule therefore also brings up the ECA UI and the
Parameters UI. The submodule ships no `src/`, no config, no schema.

## Permission

`eca_parameters_ui.permissions.yml`:

```yaml
administer eca parameters:
  title: 'Administer ECA parameters'
  restrict access: true
```

`restrict access: true` marks it as a security-sensitive permission. Grant it only to trusted
administrator roles.

## Route

`eca_parameters_ui.routing.yml`:

```yaml
entity.eca.parameters:
  path: '/admin/config/workflow/eca/parameters'
  defaults:
    _title_callback: '\Drupal\parameters_ui\Controller\ParametersUiController::parametersCollectionTitle'
    _controller:     '\Drupal\parameters_ui\Controller\ParametersUiController::parametersCollectionForm'
    parameters_collection_id: 'eca'
  requirements:
    _permission: 'administer eca parameters'
  options:
    _parameters_ui: true
```

- The controller comes entirely from the `parameters_ui` module; this submodule only binds it to a
  fixed collection id (`eca`) and its own permission.
- Access is enforced by `administer eca parameters` (not `access content`, not `_access: TRUE`).

## Menu task

`eca_parameters_ui.links.task.yml` adds a **"Parameters"** local task (`entity.eca.parameters`,
weight 150) whose `base_route` is `entity.eca.collection`, so it appears as a tab in the ECA admin
area at `/admin/config/workflow/eca`.

## Operating it

1. Enable the submodule.
2. Grant `administer eca parameters` to the intended role(s).
3. Go to `/admin/config/workflow/eca` → **Parameters** tab (or directly to
   `/admin/config/workflow/eca/parameters`).
4. Add/edit/remove parameters on the `eca` collection — the same collection the base module's
   *Get parameter* / *Set parameter* actions and conditions resolve against.
