# Installation

## Requirements

Menu Admin per Menu has no third‑party requirements — it only leans on core menu functionality:

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11.0 || ^12`).
- Core's **Menu UI** module (`menu_ui`) and **Menu Link Content** module (`menu_link_content`). These are the module's only dependencies, and Drupal enables them automatically when you turn on Menu Admin per Menu.

There are no PHP extension or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_admin_per_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_admin_per_menu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_admin_per_menu -y
```

That's all it takes — the module ships no submodules. Once enabled, head to **People → Permissions** to assign the per‑menu permissions it generates (see the [How to use it](../index.md#how-to-use-it) section).
