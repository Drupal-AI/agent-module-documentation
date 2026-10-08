# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`), including Drupal 10 and
  11.
- The **Pathauto** module
  ([`pathauto`](https://www.drupal.org/project/pathauto)) — the required
  dependency. Pathauto is a separate contrib project (it in turn requires the
  Token module), so Composer will pull it in for you with the `-W` flag below.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pathauto_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Pathauto (and
Token) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pathauto_export -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pathauto_export -y
```

Drupal will enable Pathauto (and Token) at the same time if they aren't already
on.

## Verify it worked

Open the export action from the URL‑aliases admin area (**Configuration → Search
and metadata → URL aliases**), run an export of all aliases, and confirm a CSV
file is produced containing your site's aliases.
