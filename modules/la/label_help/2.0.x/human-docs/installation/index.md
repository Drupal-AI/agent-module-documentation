# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/label_help -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/label_help -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en label_help -y
```

Once enabled, a **Label help message** textarea appears on every field's settings
form — see [Configuration](../configuration/index.md) for how to add help text.

## Optional demo submodule

Label Help bundles one submodule, **label_help_test**, which provides a demo content
type wired up with many field types so you can see the placements in action. It is
for demonstration/testing only — enable it on a scratch site if you want to
experiment, and leave it disabled in production:

```bash
drush en label_help_test -y
```
