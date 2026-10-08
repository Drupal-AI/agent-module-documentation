# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Drupal Commerce** with the **Order** module — the module depends on `commerce`
  and `commerce_order`.
- The **Inline Entity Form** module (`inline_entity_form`).
- Core's **Options** module (`options`).

All of these are enabled automatically as dependencies. The module is compatible
with Drupal Commerce 2.x and 3.x. There are no additional PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_fee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Inline Entity Form.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_fee -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_fee -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration** and confirm a **Fees** listing
is now available alongside promotions. From there you can add your first fee — see
"How to use it" on the [overview page](../index.md).
