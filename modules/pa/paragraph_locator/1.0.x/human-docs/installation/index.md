# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Paragraphs** module, which Paragraph Locator works against.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_locator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_locator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_locator -y
```

## Grant the permission

Paragraph Locator provides its own permission that controls who can see the usage
dashboard. Go to **People → Permissions** (`/admin/people/permissions`) and grant it
only to trusted roles — typically administrators or site builders — since the
dashboard exposes where content lives and offers links to modify or delete it.

## Verify it worked

As a user with the permission, open the Paragraph Locator dashboard under
**Configuration → Content** (`/admin/config/content/`). If the dashboard loads and
lists paragraph usage, the module is installed and working.
