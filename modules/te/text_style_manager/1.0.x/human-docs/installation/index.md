# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — the only dependency, which Drupal enables
  automatically as a dependency when you turn on Text Style Manager.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/text_style_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_style_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Note:** the project is seeking a new maintainer and is in
> maintenance-fixes-only status. Test it before relying on it in production.

## Enable the module

```bash
drush en text_style_manager -y
```

## Verify it worked

Go to **Configuration → User interface → Text Style Settings**
(`/admin/config/user-interface/text-style-settings`). If the settings form
opens, the module is installed and you can start setting per-section text styles
— see [Configuration](../configuration/index.md).
