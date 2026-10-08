# Installation

## Requirements

- **Drupal core 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- An **account on the Chatlio service** (that's where you get the embed code).

There are no other module dependencies and no PHP or JavaScript libraries to
install manually — the widget script is served by Chatlio.

## Install with Composer

From the project root:

```bash
composer require drupal/chatlio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chatlio -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chatlio -y
```

## Verify it worked

After entering your embed code on the settings page (see
[Configuration](../configuration/index.md)), visit a front‑end page. The Chatlio
chat widget should appear. To remove it later, uninstall the module as normal.
