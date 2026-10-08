# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Language** (`language`) and **Menu UI** (`menu_ui`) modules — both are
  the module's only dependencies, and Drupal enables them automatically when you
  turn on Language Links On Menu.

No third‑party Composer or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/llom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llom -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llom -y
```

## Before it will do anything useful

The switcher only makes sense once your site is multilingual, so make sure you
have:

1. **At least two languages** at `/admin/config/regional/language`, and
2. The **URL** detection method enabled and prioritised under
   `/admin/config/regional/language/detection`.

## Verify it worked

Go to **Configuration → Regional and language → Language Links On Menu**
(`/admin/config/regional/llom`), pick a menu, save, and then view a page that
shows that menu — the language switcher should appear as a menu item. See
[Configuration](../configuration/index.md) for each setting.
