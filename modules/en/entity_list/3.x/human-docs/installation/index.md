# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Drupal core's **Layout Discovery** module (`layout_discovery`) — it ships with
  core and is enabled automatically as a dependency.
- No third-party PHP or JavaScript libraries.

The **FAPI_Collapsible** module is recommended (not required) if you want a list's
filter form to render as a collapsible element.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_list -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_list -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_list -y
```

Drupal enables Layout Discovery at the same time if it isn't already on.

## Verify it worked

Log in as an administrator and confirm you can create a new **Entity List** from
the admin UI. Build a small test list — pick an entity type and bundle, set the
results per page, save it — and view the result to confirm the listing renders.
