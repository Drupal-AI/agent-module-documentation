# Data source — Drupal.org JSON:API

Popular Drupal 11 modules, sorted by active installs, paginated.

## Query

```
https://www.drupal.org/jsonapi/node/project_module
  ?sort=-field_active_installs_total
  &filter[min][condition][path]=field_core_semver_minimum
  &filter[min][condition][operator]=<=      (url-encoded %3C%3D)
  &filter[min][condition][value]=11999999
  &filter[max][condition][path]=field_core_semver_maximum
  &filter[max][condition][operator]=>=      (url-encoded %3E%3D)
  &filter[max][condition][value]=11000000
```

The two filters mean: `core_semver_minimum <= 11.999999` AND
`core_semver_maximum >= 11.000000` — i.e. the module's supported core range overlaps
Drupal 11.

## Pagination

- Page size is ~8. Advance with `page[offset]` (multiples of the page size), optionally
  with `page[limit]`.
- The offset we have reached is persisted in [`../pagination.md`](../pagination.md) as a
  bare integer so any agent can resume.

## Fields we use (attributes on `node--project_module`)

| Field | Use |
|---|---|
| `field_project_machine_name` | the module's `data_name` and directory name |
| `title` | human-readable `name` |
| `body` | description fallback (info.yml wins) |
| `field_composer_namespace` | `composer require` target, e.g. `drupal/token` |
| `field_active_installs_total` | popularity → `active_installs` in data.json |
| `field_core_semver_minimum` / `_maximum` | core compatibility sanity check |
| `field_security_advisory_coverage` | whether the project has security coverage |
| `field_module_categories` (relationship) | official categories (resolve via include) |

Other attributes present: `drupal_internal__nid`, `status`, `created`, `changed`,
`field_project_has_releases`, `field_logo_url`, `field_issue_summary_template`.

## Categories

Category names come from the `module_categories` taxonomy:

```
https://www.drupal.org/jsonapi/taxonomy_term/module_categories?fields[taxonomy_term--module_categories]=name&page[limit]=50
```

To get a module's categories in one call, include the relationship:

```
.../node/project_module?filter[field_project_machine_name]={name}&include=field_module_categories
```

The 20 official categories are seeded in [`../categories.yml`](../categories.yml).

## Versions

The feed does **not** list releases. Get the actual version from `composer require`
output (or `composer show drupal/{name}`) and from
`web/modules/contrib/{name}/{name}.info.yml`.
