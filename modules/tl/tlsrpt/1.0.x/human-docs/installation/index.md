# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2 || ^12`).
- The **JSON Field** module (`json_field`), which TLSRPT depends on to store
  reports as JSON. Composer pulls this in automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/tlsrpt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in the JSON Field dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tlsrpt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tlsrpt -y
```

Drupal enables the JSON Field dependency at the same time.

## Verify it worked

After enabling, check the two permissions the module adds — `administer tlsrpt`
and `create tlsrpt` — on the People → Permissions page, and grant them only to the
roles that should be able to administer the endpoint or submit reports. The
reporting endpoint is active as soon as the module is enabled; there is no
settings form to complete.
