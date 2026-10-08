# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- No hard module dependencies and no third-party Composer or PHP libraries.
- **Optional integrations:**
  - **Entity Print** (`drupal/entity_print`) — enables the "Print to PDF" share
    button. Without it, that button is a harmless no-op.
  - **Forward** (`drupal/forward`) — integrates with the Mail share button when
    installed.
- FontAwesome icons are loaded from the jsDelivr CDN by default.

## Install with Composer

From the project root:

```bash
composer require drupal/social_simple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_simple -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_simple -y
```

Once enabled, configure sharing per content type or place the Social simple block —
see [Configuration](../configuration/index.md).

## Optional submodule: Social Simple Per Node

Enable **Social Simple Per Node** (`social_simple_per_node`) if you want editors to be
able to hide the share links on individual nodes:

```bash
drush en social_simple_per_node -y
```

It adds a **Social share links enabled** checkbox to the node form (governed by the
*Disable social links per node* permission). See
[Configuration](../configuration/index.md#per-node-hiding-submodule) for details.
