# Features admin UI — screens, routes, permissions

Enable with `drush en features_ui -y`. Everything lives under
`/admin/config/development/features`. Routes are in `features_ui.routing.yml`.

## Main screens

| Route | Path | Form / controller | Permission |
|---|---|---|---|
| `features.export` | `/admin/config/development/features` | `FeaturesExportForm` | `export configuration` |
| `features.edit` | `/admin/config/development/features/edit/{featurename}` | `FeaturesEditForm` | `administer site configuration` |
| `features.diff` | `/admin/config/development/features/diff/{featurename}` | `FeaturesDiffForm` | `administer site configuration` |
| `features.detect` | `/features/api/detect/{name}` | `FeaturesUIController::detect` (AJAX) | `administer site configuration` |

Package **downloads** are served by the base module's `features.export_download` route
(`/admin/config/development/features/download/{uri}`, permission `export configuration`),
producing a tar archive via the `archive` generation method.

## Bundle assignment forms

The **configure** route is `features.assignment` (Configure Bundles). Each assignment method
has its own form editing the `features_bundle` entity, all requiring
`administer site configuration`:

| Route | Path suffix | Edits |
|---|---|---|
| `features.assignment` | `/bundle/{bundle_name}` | Bundle + which methods are enabled (`AssignmentConfigureForm`) |
| `features.assignment_alter` | `/bundle/_alter/{bundle_name}` | Alter (core/uuid/user_permissions) |
| `features.assignment_base` | `/bundle/_base/{bundle_name}` | Base package types |
| `features.assignment_core` | `/bundle/_core/{bundle_name}` | Core package types |
| `features.assignment_exclude` | `/bundle/_exclude/{bundle_name}` | Exclusions |
| `features.assignment_optional` | `/bundle/_optional/{bundle_name}` | Optional (`config/optional`) |
| `features.assignment_profile` | `/bundle/_profile/{bundle_name}` | Install-profile packaging |
| `features.assignment_site` | `/bundle/_site/{bundle_name}` | Site package types |

Menu/tabs/action links: a **Features** item under Configuration → Development, local tasks for
Features / Configure Bundles / Differences, and a **Create new feature** action link (routes to
`features.edit`).

## Notes

- No config of its own — it reads/writes the base module's `features.settings` and
  `features_bundle` entities (see [../../../../../3.16.x/agent/configure/features.md](../../../../../3.16.x/agent/configure/features.md)).
- Everything here is also doable headless via `drush features:*`
  ([../../../../../3.16.x/agent/drush/features.md](../../../../../3.16.x/agent/drush/features.md)); the UI
  is optional and can be omitted in code-first/CI workflows.
