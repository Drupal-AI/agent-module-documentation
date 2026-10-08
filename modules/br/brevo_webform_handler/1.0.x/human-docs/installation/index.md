# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Webform** module (`webform`), which this handler depends on — Drupal
  enables it automatically as a dependency.
- A Brevo (Sendinblue) account and an API key.
- Outbound HTTPS access from the server to the Brevo Contacts API.

There are no third-party Composer or PHP library requirements from this module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/brevo_webform_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Webform module) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/brevo_webform_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brevo_webform_handler -y
```

This also enables the Webform module if it is not already on. There is no global
settings page — you configure the handler on each Webform that should feed Brevo.
See [Configuration](../configuration/index.md).
