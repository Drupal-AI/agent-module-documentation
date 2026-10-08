# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement:
  ^8||^9||^10||^11||^12`).
- No other contributed modules, PHP extensions, or third‑party libraries are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/js_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/js_editor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en js_editor -y
```

## A word on who can use it

Before anyone can add custom JavaScript, they need the **Execute arbitrary
js_editor scripts** permission. Because that JavaScript runs in every visitor's
browser, this permission effectively hands over control of the site — grant it
only to fully trusted administrators. Review it at **People → Permissions**
(`/admin/people/permissions`) right after enabling the module.

## Verify it worked

Go to **Appearance** (`/admin/appearance`) and open the **Settings** page of an
installed theme. Scroll to the bottom — you should see a checkbox to enable custom
JavaScript and a code editor. See [Configuration](../configuration/index.md) for
how to use them.
