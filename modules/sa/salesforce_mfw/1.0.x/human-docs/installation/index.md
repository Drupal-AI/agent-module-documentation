# Installation

## Requirements

- **Drupal 10.2+, 11 or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- **Token** (`token`) — enabled automatically as a dependency.
- **A Salesforce account** on a service tier that provides the Messaging for Web
  functionality, and the embed parameters it gives you (organization ID, config
  name, and the site / snippet / utility-bootstrap URLs).

There are no submodules and no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/salesforce_mfw -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/salesforce_mfw -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en salesforce_mfw -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and place a block —
the **Salesforce MFW** block should be available to add. Enabling the module alone
shows no chat; the widget only appears once you have placed and configured that
block. See [Configuration](../configuration/index.md) for the parameters to enter.
