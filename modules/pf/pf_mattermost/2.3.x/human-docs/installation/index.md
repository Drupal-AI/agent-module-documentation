# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Push Framework** (`push_framework`) module — this is a hard dependency;
  Push Framework Mattermost is a channel plugin for it. Composer pulls it in when
  you require this module.
- A **Mattermost** server, a **personal access token**, and the **id of the
  target channel**.
- The **Gnello Mattermost PHP driver** — pulled in automatically by Composer when
  you require this module.

## Install with Composer

From the project root:

```bash
composer require drupal/pf_mattermost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it fetches the required Push Framework module and the
Gnello driver.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pf_mattermost -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pf_mattermost -y
```

This enables the Push Framework too if it is not already on.

## Verify it worked

Log in as an administrator and open **Configuration → System → Push framework →
Mattermost** (`/admin/config/system/push_framework/mattermost`). The settings form
should load, ready for your Mattermost domain, token, and channel id — see
[Configuration](../configuration/index.md).
