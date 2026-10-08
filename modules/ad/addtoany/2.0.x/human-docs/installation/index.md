# Installation

## Requirements

AddToAny needs **Drupal 10.1+ or 11** and core's **Node** module (`node`), which
ships with Drupal and is enabled as a dependency. There are no external PHP library
requirements — the sharing widget itself is loaded from AddToAny's hosted platform
at run time, so the buttons rely on the visitor's browser reaching that service.

## Install with Composer

From the project root:

```bash
composer require drupal/addtoany -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addtoany -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addtoany -y
```

Once enabled, the settings form appears under **Configuration → Web Services →
AddToAny** (`/admin/config/services/addtoany`).

## Verify it worked

Log in as an administrator and go to `/admin/config/services/addtoany`. You should
see the **AddToAny** settings page with a **Buttons** section (containing an **Icon
size** field and the **Service Buttons** HTML), a **Universal Button** section, plus
**Additional options** and **Entities** sections and a **Save configuration**
button:

![The AddToAny settings page after installation](../images/settings.png)

If that page loads, the module is installed correctly. Next, work through the
[configuration](../configuration/index.md) to choose your buttons and where they
appear.
