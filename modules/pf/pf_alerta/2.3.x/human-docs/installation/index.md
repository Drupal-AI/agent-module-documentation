# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Push Framework** (`push_framework`) module — this is a hard dependency;
  Push Framework Alerta is a channel plugin for it. Composer pulls it in when you
  require this module.
- An **Alerta** instance to receive the notifications (and, if it is secured, an
  API key/credentials for it).
- Optional: **DANSE** with its **DANSE Log** submodule, if you want log entries
  above an error threshold pushed to Alerta.

## Install with Composer

From the project root:

```bash
composer require drupal/pf_alerta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it fetches the required Push Framework module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pf_alerta -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pf_alerta -y
```

This enables the Push Framework too if it is not already on.

## Verify it worked

Log in as an administrator and open the Push Framework configuration (under
**Configuration → System → Push framework**). The **Alerta** channel should now
appear among the available channels, ready to be configured and enabled — see
[Configuration](../configuration/index.md).
