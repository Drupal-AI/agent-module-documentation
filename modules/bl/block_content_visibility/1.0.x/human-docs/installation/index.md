# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block content** module (`block_content`).
- The **Block form alter** module (`block_form_alter`), which Composer pulls in
  as a dependency.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_content_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
required dependencies, including `block_form_alter`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_content_visibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_content_visibility -y
```

After enabling, grant the **Administer block content visibility** permission to
the appropriate roles, then set conditions on any custom block — see
[How to use it](../index.md#how-to-use-it).
