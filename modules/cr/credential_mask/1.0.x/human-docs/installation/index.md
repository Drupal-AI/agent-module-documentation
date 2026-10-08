# Installation

## Requirements

- **Drupal 8.8 or newer**, including 9, 10, and 11
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Drush 10 or greater**, if you want to manage the sensitive-key list from the
  command line (the admin page works without Drush).
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/credential_mask -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/credential_mask -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en credential_mask -y
```

Enabling the module does not mask anything yet — nothing is treated as sensitive
until you add keys to the list. Head to [Configuration](../configuration/index.md)
to mark which configuration properties should be masked.

## Verify it worked

After you have marked at least one key as sensitive (see Configuration), run
`drush config:export` and inspect the exported YAML: the sensitive property should
be masked rather than showing its real value. You can also confirm the current list
with `drush credential_mask:list`.
