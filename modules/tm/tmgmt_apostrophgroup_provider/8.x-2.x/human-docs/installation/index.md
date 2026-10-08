# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Translation Management Tool** module (`tmgmt`) and its **TMGMT File**
  submodule (`tmgmt_file`) — both are dependencies and Composer pulls them in.
- Credentials from **Apostroph Group**: a username, a password, and a
  client/customer id. Contact Apostroph Group to obtain these.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_apostrophgroup_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in TMGMT and TMGMT File.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_apostrophgroup_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_apostrophgroup_provider -y
```

This also enables TMGMT and TMGMT File if they are not already on.

## Verify it worked

Go to **Configuration → Regional and language → Translation providers** (TMGMT →
Providers). When you add a new translator, **Apostroph Group Connector** should
appear as an available plugin. Continue to [Configuration](../configuration/index.md)
to fill in your credentials.
