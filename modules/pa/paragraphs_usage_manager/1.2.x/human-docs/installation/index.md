# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **PHP 8.1** or newer.
- The **Paragraphs** module (`paragraphs`) — a hard dependency, enabled
  automatically as a dependency.

No additional third‑party library is required.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_usage_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_usage_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_usage_manager -y
```

Drupal will enable Paragraphs automatically if it is not already on.

## Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant the
**administer paragraphs usage manager** permission to the administrator roles that
should manage paragraph usage, then save.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then, as a user
with the permission above, open **Configuration → Content authoring → Paragraphs
Usage Manager**. Your first step is to select which entity types should be scanned
for paragraph reference fields — see [Configuration](../configuration/index.md).
