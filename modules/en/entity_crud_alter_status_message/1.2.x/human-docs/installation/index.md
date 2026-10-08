# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Token](https://www.drupal.org/project/token)** module (`token`) — this is
  a required dependency. Composer pulls it in automatically with the command below.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_crud_alter_status_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
Token dependency alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_crud_alter_status_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_crud_alter_status_message -y
```

Enabling this module also enables Token if it isn't already on.

## Verify it worked

The module shows no change until you define at least one message. Go to
[Configuration](../configuration/index.md), create a message for (say) a node
create action, then create a node of that type — you should see your custom
confirmation message instead of the default one.
