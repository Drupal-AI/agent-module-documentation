# Installation

## Requirements

Page Tree expects a full front-end publishing stack to be present:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Node**, **Block**, **HAL**, and **Menu Link Content** modules.
- Contrib **Pathauto** (`pathauto`) — for page URL aliases.
- Contrib **REST Consumer** (`restconsumer`).
- Contrib **Frontend Publishing** (`frontendpublishing`) — Page Tree is designed
  to work inside this decoupled publishing workflow.

Composer pulls the contrib dependencies in for you when you require the module
with the `-W` flag below. There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pagetree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Pathauto, REST Consumer, and Frontend
Publishing.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagetree -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagetree -y
```

Drupal enables the dependency modules automatically as part of this step.

## Verify it worked

Log in as an administrator and go to **Configuration → Page Tree**
(`/admin/config/pagetree`) — the settings form should load. Next, work through
[Configuration](../configuration/index.md) to pick the menus and content types to
display and to place the Page Tree Block in your theme.
