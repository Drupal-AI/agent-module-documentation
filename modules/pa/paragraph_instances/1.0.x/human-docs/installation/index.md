# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Paragraph Instances is designed for paragraph‑based sites, so you will naturally
have the Paragraphs module in place, but it has no third‑party Composer or PHP
library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_instances -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_instances -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_instances -y
```

## Grant the permission

The module provides its own permission that controls who may run the usage report.
Go to **People → Permissions** (`/admin/people/permissions`) and grant it to the
roles that should be able to audit paragraph usage — typically administrators or
site builders. Because the report reads across your content, keep it restricted to
trusted roles.

## Verify it worked

As a user with the permission, open the paragraph‑usage report and pick a paragraph
type. You should see a list of the nodes that use it. If the report loads and
returns results for a type you know is in use, the module is working.
