# Installation

## Requirements

Field Permissions runs on **Drupal 9.5, 10, or 11** (`core_version_requirement:
^9.5 || ^10 || ^11`). Its only dependency is core's **Field** module (`field`),
which ships with Drupal and is enabled on any standard site — so there are no extra
contrib modules to pull in.

## Install with Composer

From the project root:

```bash
composer require drupal/field_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/field_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_permissions -y
```

## Verify it worked

Log in as an administrator and go to **Reports → Field list → Permissions**
(`/admin/reports/fields/permissions`). You should see the **Field permissions**
report — a matrix listing every field on the site alongside its configured
permission type:

![The Field permissions report after installation](../images/report.png)

Newly installed, every field reads *"Not set (Field inherits content
permissions.)"* — that is the **Public** default. Once the report page loads, the
module is installed correctly. Next, head to
[Configuration](../configuration/index.md) to set permissions on a field.
