# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The **Lingotek / Ray Enterprise Translation** module (`lingotek`) — this module
  is an add‑on to it and depends on it. Install and connect Lingotek first (see its
  [manual setup guide](../../../../lingotek/11.0.x/human-docs/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/lingotek_copy_target -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lingotek_copy_target -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lingotek_copy_target -y
```

## Verify it worked

Edit one of your languages (**Configuration → Regional and language → Languages**,
then edit a language). You should see a Lingotek Copy Target section on the
language edit form where you can add a copy‑target mapping — see
[Configuration](../configuration/index.md).
