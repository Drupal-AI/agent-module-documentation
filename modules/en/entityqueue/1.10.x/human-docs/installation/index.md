# Installation

## Requirements

Entityqueue runs on **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 ||
^11`) and has **no other module dependencies** — nothing extra is pulled in when you
install it. To display a queue you will use core's **Views** module, which ships with
Drupal and is enabled by default on the Standard profile.

The project also bundles an optional **Entityqueue Smartqueue** submodule
(`entityqueue_smartqueue`), which auto-creates a subqueue per entity of a chosen type.
Enable it separately only if you need that behaviour.

## Install with Composer

From the project root:

```bash
composer require drupal/entityqueue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entityqueue -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityqueue -y
```

Once enabled, the queue screens appear under **Structure → Entityqueues**
(`/admin/structure/entityqueue`).

## Verify it worked

Log in as an administrator and go to `/admin/structure/entityqueue`. You should see the
**Entityqueues** list with a **+ Add entity queue** button and empty **Enabled** and
**Disabled** tables:

![The Entityqueues list after installation](../images/list.png)

If the page loads and the button is present, the module is installed correctly. Next,
[create and display your first queue](../configuration/index.md).
