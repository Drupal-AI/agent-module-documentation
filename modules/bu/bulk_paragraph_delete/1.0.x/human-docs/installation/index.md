# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`), which this module depends on.
- No third-party Composer or PHP library requirements beyond Paragraphs.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_paragraph_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Paragraphs dependency if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bulk_paragraph_delete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_paragraph_delete -y
```

Access follows the normal Paragraphs administration permissions, so make sure
only trusted admins can reach paragraph-type administration. Then use the bulk
delete from the admin UI — see [How to use it](../index.md#how-to-use-it) — and
back up before deleting, since it is destructive.
