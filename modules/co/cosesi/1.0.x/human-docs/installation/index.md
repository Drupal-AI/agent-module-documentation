# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`; the project recommends Drupal
  11.3 or newer).
- **PHP 8.4 or newer**, per the project's stated requirements.
- Core's **Configuration Manager** module (`config`) — the only module dependency,
  which Drupal enables automatically.
- A **frontend theme that applies styles based on the `color-scheme` CSS property
  or on the HTML classes** you configure in the module. Without such a theme the
  switcher toggles state but nothing visibly changes.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cosesi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cosesi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cosesi -y
```

## Verify it worked

After enabling, go to **Configuration → Color Scheme Switcher**
(`/admin/config/cosesi/theme-settings`) — you should see the per‑theme settings
form. The switcher itself won't appear on the frontend until you place its block;
see [Configuration](../configuration/index.md).
