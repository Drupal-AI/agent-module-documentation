<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee Extras — project structure

## Install & enable

```bash
composer require drupal/apigee_extras
drush en apigee_extras -y          # pulls in apigee_edge; adds no features on its own
drush en apigee_extras_views -y    # optional: Views bridge for developer apps
drush en apigee_extras_bootstrap -y # optional: Bootstrap 5 badges for status_property
```

The base module (`apigee_extras.info.yml`) declares `dependencies: [apigee_edge:apigee_edge]` and
`core_version_requirement: ^10.3 || ^11.1`. There is no `.module`, `src/`, routing, services,
permissions or config in the base module — enabling it alone only guarantees Apigee Edge is present.

## The two submodules (both depend on `apigee_extras`)

| Submodule | Adds | Key file(s) |
|---|---|---|
| `apigee_extras_views` | `apigee_app` Views base table + `apigee_app_field` field handler + `apigee_app_query` query plugin | `apigee_extras_views.module` (`hook_views_data`), `src/Plugin/views/field/ApigeeAppField.php`, `src/Plugin/views/query/ApigeeAppQuery.php`. Also depends on `views:views`. |
| `apigee_extras_bootstrap` | `hook_preprocess_status_property()` mapping Apigee status → Bootstrap 5 `bg-*` badge classes | `apigee_extras_bootstrap.module`. Expects a Bootstrap 5 theme (e.g. `bootstrap5`). |

See each submodule's own `agent/start.md` for details:

- [../modules/apigee_extras_views/1.0.x/agent/views/integration.md](../../modules/apigee_extras_views/1.0.x/agent/views/integration.md)
- [../modules/apigee_extras_bootstrap/1.0.x/agent/theming/badges.md](../../modules/apigee_extras_bootstrap/1.0.x/agent/theming/badges.md)

## Notes

- Nothing here configures Apigee itself. Connection credentials, org/environment and the developer-app
  entities all come from the base **Apigee Edge** module; these submodules only read/theme that data.
- The submodules are independent: enable one without the other.
