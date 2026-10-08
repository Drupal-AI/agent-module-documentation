# Installation

## Requirements

Entity Reference Extensions needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's entity‑reference field support and **Field UI** (to select the
  formatters on *Manage display*). There are no other module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entityreference_extensions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entityreference_extensions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityreference_extensions -y
```

That's all the setup needed. The three **(PLUS)** formatters are now available on
the *Manage display* tab for any multi‑value entity‑reference field. See the
[overview](../index.md#how-to-use-it) for how to select and configure them, and
for setting the optional `unlimitedcounter` value.
