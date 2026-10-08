# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Remote Stream Wrapper** module (`drupal/remote_stream_wrapper` `^2.1`).
  This is a hard dependency — it supplies the `http`/`https` stream wrappers and
  does the actual fetching of remote files. Composer pulls it in automatically
  when you require this module.

There are no other PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/remote_stream_wrapper_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
Remote Stream Wrapper module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/remote_stream_wrapper_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remote_stream_wrapper_widget -y
```

Enabling it also enables `remote_stream_wrapper` if it isn't already on. There
is no configuration step — the new **Remote stream wrapper** widget becomes
available to choose on any File or Image field from its bundle's **Manage form
display** tab (see [How to use it](../index.md#how-to-use-it)).
