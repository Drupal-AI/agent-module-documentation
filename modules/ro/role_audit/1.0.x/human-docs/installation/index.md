# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Drupal core only (the User and Routing systems) — there are no external
  dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/role_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_audit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_audit -y
```

## Verify it worked

Log in as an administrator and go to **People → Role Audit**
(`/admin/people/role-audit`). If the page loads with the Permissions Audit and Route
Audit tools, the module is working. There is nothing to configure — pick two roles
and generate a comparison.
