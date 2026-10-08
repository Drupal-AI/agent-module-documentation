# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A **Bothive account** at [bothive.be](https://bothive.be), since the widget
  connects to their service. The chatbot is a third-party product — you will need
  whatever account identifier or credential Bothive gives you.

There are no third-party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bothive -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bothive -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bothive -y
```

After enabling, grant the `administer bothive configuration` permission and
connect your Bothive account — see [Configuration](../configuration/index.md).
Because the widget sends visitor interactions to a third-party service, review
Bothive's privacy terms before making it live.
