# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field**, **Link**, and **Options** modules enabled — Typed Link builds on all
  three. Drupal enables them automatically as dependencies. (Field and Link are part of the
  standard install; Options provides the allowed‑values handling for the link type.)

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/typed_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/typed_link -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en typed_link -y
```

Enabling the module makes the **Typed Link** field type (with its widget and formatter)
available when you add a field. If the Link or Options modules aren't already on, Drupal
enables them as dependencies.

## Next step

There is no configuration form. Head to the [overview](../index.md) for how to add and
configure a Typed Link field, including defining the allowed link types.
