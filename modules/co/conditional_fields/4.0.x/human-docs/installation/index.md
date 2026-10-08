# Installation

## Requirements

Conditional Fields runs on **Drupal 9, 10 or 11** (`^9 || ^10 || ^11`). Its only
dependency is core's **Field** module (`field`), which ships with Drupal and is
already enabled on any site that has fields — so there are no extra contrib
modules to pull in.

## Install with Composer

From the project root:

```bash
composer require drupal/conditional_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any packages it
needs to satisfy the requirement.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conditional_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conditional_fields -y
```

Once enabled, the configuration screen appears under **Structure → Conditional
fields** (`/admin/structure/conditional_fields`).

## Verify it worked

Log in as an administrator and go to `/admin/structure/conditional_fields`. You
should see the **Conditional fields** page listing every entity type on the site:

![The Conditional fields page after installation](../images/list.png)

If the page loads and shows the list of entity types, the module is installed
correctly. Next, [add your first field dependency](../configuration/index.md).
