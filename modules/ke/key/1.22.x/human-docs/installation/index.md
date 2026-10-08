# Installation

## Requirements

Key runs on **Drupal 9.1+, 10, or 11** (`core_version_requirement: ^9.1 || ^10 ||
^11`). It has **no other module dependencies** — nothing else needs to be installed
for it to work.

Optional but recommended:

- **Drush** (`drush/drush`, version 11 or newer) — Key registers a set of `key:*`
  commands (see [Adding a key](../adding-a-key/index.md)) that let you create and
  read keys from the command line. Most sites already have Drush installed.

## Install with Composer

From the project root:

```bash
composer require drupal/key -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update anything it needs to
while resolving the package.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/key -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Keys**
(`/admin/config/system/keys`). You should see the **Keys** listing with an
**+ Add Key** button:

![The Keys listing after installation](../images/list.png)

If the page loads with the **Key**, **Type**, **Provider**, **Overrides**, and
**Operations** columns, the module is installed correctly. Next, review the
[Keys listing and key concepts](../configuration/index.md), then
[add your first key](../adding-a-key/index.md).
