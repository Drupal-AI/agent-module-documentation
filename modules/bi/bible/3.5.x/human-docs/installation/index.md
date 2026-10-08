# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Field**, **File**, **Filter**, **Text**, **User** and **Views** modules.
  These ship with Drupal and are enabled automatically as dependencies when you turn
  on Bible.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bible -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bible -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bible -y
```

After enabling, review the permissions it adds under **People → Permissions** and
grant them to the appropriate roles, then import a Bible translation to start
browsing scripture.
