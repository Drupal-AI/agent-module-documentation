# Installation

## Requirements

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Token** module (`token`), which is a hard dependency — Node Token extends
  Token's token definitions. Composer pulls it in automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Token module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_token -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_token -y
```

That is the entire setup. There is no configuration page, no permissions to grant
and no content to change. Rebuild caches (`drush cr`) if the new per-content-type
token types don't show up straight away, since the token definitions are built and
cached.

There are no submodules.
