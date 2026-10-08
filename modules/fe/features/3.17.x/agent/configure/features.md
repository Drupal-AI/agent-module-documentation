# Configure — bundles, assignment settings, export folder

Features has **no config form in the base module** (the `features_ui` submodule provides the
UI). Behavior is driven by two config objects.

## `features.settings` (config object)

Schema: `config/schema/features.schema.yml`. Holds the export destination:

| Key | Meaning |
|---|---|
| `export.folder` | Subfolder inside a module where config is written (default export folder). |
| `langcode` | Language code used for export. |

Read/set with `drush cget features.settings` / `drush cset features.settings export.folder <dir>`.

## `features_bundle` config entity

A **bundle** namespaces a set of features and stores how the assignment pipeline runs. Entity
`Drupal\features\Entity\FeaturesBundle` (config prefix `features.bundle.`, id key
`machine_name`). A `default` bundle ships at `config/install/features.bundle.default.yml`.
Exported keys (`config_export`): `name`, `machine_name`, `description`, `assignments`,
`profile_name`, `is_profile`.

`assignments` is a keyed map of assignment-method id → per-method settings, each with at least
`enabled` (bool) and `weight` (int), plus method-specific keys. The default bundle enables
these assignment methods (id → weight):

| id | weight | Role (schema `features.assignment.<id>`) |
|---|---|---|
| `packages` | -20 | Assign config already declared by existing feature packages. |
| `exclude` | -5 | Exclude site-specific config (`curated`, `module.installed/profile/namespace`, and excludes `features_bundle` itself). |
| `base` | -2 | Base package types (e.g. `node_type`, `comment_type`, content `user`). |
| `forward_dependency` | 4 | Resolve forward dependencies. |
| `core` | 5 | Core-provided types (date_format, field_storage_config, image_style, menu, user_role, …). |
| `site` | 7 | Site-level types (action, contact_form, filter_format, taxonomy_vocabulary, editor, …). |
| `profile` | 10 | Add install-profile config (`curated`, `standard.files/dependencies`, types like block, migration, tour). |
| `existing` | 12 | Assign to existing modules. |
| `dependency` | 15 | Add config dependencies. |
| `alter` | 0 | Strip data before export: `core` (remove `_core`), `uuid`, `user_permissions`. |
| `namespace` | 0 | Assign config to a package matching its module namespace. |
| `optional` | 0 | Route config into `config/optional`. |

Create a bundle in code:

```php
use Drupal\features\Entity\FeaturesBundle;

FeaturesBundle::create([
  'machine_name' => 'acme',
  'name' => 'Acme',
  'assignments' => [ /* per-method settings, mirroring the default bundle */ ],
])->save();
```

CLI selection: pass `--bundle=acme` to any `drush features:*` command to act within that
bundle's namespace. `provides_config_schema` is true, so both `features.settings` and every
`features.bundle.*` entity export/deploy with `drush config:export`.
