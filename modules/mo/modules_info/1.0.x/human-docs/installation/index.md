# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No PHP version constraint beyond what your Drupal core requires.
- **No third‑party module or library dependencies.**

## Install with Composer

From the project root:

```bash
composer require drupal/modules_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modules_info -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modules_info -y
```

## Grant permissions

Modules Info provides its own permissions. Grant them to trusted roles at **People →
Permissions** (`/admin/people/permissions`) — remember the module/version listing is
fingerprinting data, so be cautious about who can see the block.

## Verify it worked

Go to **Content → Modules** and add a module entry; its data should populate
immediately. Then place the **Modules Info** block via **Structure → Block layout**
(`/admin/structure/block`) and view a page where the block appears — you should see the
modules table with links. See "How to use it" in the [overview](../index.md) for the
full workflow.
