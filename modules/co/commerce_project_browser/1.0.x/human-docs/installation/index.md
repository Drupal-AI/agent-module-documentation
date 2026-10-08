# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Project Browser** module (`project_browser`) — this module adds a source to
  it, and Drupal enables it as a dependency.

There are no third‑party Composer or PHP library requirements. This is an **alpha**
release and the project is **not covered** by Drupal's security advisory policy, so
try it on a non-production copy first and keep it restricted to trusted
administrators.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_project_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_project_browser -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_project_browser -y
```

Enabling it also enables Project Browser if it is not already on.

## Verify it worked

Open a Commerce page the module targets — e.g. **Commerce → Configuration → Payment
gateways** — and look for its "Browse marketplace" / "Add …" local action. It opens a
Project Browser listing of the relevant Commerce recipes, which you can install via
Project Browser's normal workflow. (Each category also has a direct browse URL,
`/admin/modules/browse/commerce_packagist_recipes:<category>`.) Because installing
recipes adds code to your site, make sure only trusted administrators have access to
this workflow.
