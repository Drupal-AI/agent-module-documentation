# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Domain** module (`domain`) — this is a required dependency and must be
  installed and configured with your domains first. Composer pulls it in with the
  command below.

There are no third‑party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dbc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Domain
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dbc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dbc -y
```

Enabling Domain Base Css will also enable Domain if it isn't already on. Make sure
your domains are set up in the Domain module before you configure per-domain CSS.

## Verify it worked

Log in as an administrator and go to **Configuration → Domain → Domain CSS
Switcher** (`/admin/config/domain/domain_css_switcher`). You should see one CSS
upload field for each domain you have configured. From here, continue to
[Configuration](../configuration/index.md) to upload your stylesheets.
