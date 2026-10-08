# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party module or PHP library dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/editing_helper -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/editing_helper -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editing_helper -y
```

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep editing_helper
```

Then visit **Configuration → Content authoring → Description Helper**
(`/admin/config/content/editing_helper/config`) to set up your help text. The
helper button won't appear for editors until you configure the help content and
grant the **"Access to editing helper"** permission — see
[Configuration](../configuration/index.md).
