# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`) and **Image** (`image`) modules — both are part of a
  standard Drupal install.

## Install with Composer

From the project root:

```bash
composer require drupal/ispim -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ispim -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ispim -y
```

## Verify it worked

Go to **Configuration → Media → Image Style Preview Images**
(`/admin/config/media/ispim-preview-image`). If the management screen loads, the
module is installed. Upload an image there, then open any image style under
**Configuration → Media → Image styles** and confirm the preview uses your image —
see [Configuration](../configuration/index.md).

> **Tip:** This module is mainly useful while you are setting up image styles. Once
> your styles are finalised you can safely disable it.
