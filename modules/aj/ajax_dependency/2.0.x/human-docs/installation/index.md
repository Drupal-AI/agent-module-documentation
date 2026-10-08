# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other modules — it has no dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_dependency -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajax_dependency -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_dependency -y
```

The helper service is now available to your custom form code. There is no
configuration form.

## Optional: the example submodule

The project ships one submodule, **`ajax_dependency_example`**, which shows the
service in action in a working form. Enable it as a reference:

```bash
drush en ajax_dependency_example -y
```

Disable it again once you no longer need the example.
