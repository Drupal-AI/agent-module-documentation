# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's **Views** module (`views`) enabled.
- The **[Conditions Helper](https://www.drupal.org/project/conditions_helper)**
  module (`drupal/conditions_helper` `^1.0`) — this provides the condition-building
  form and evaluator the plugin relies on. Composer pulls it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/views_access_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Conditions Helper
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_access_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drupal will offer to enable Views and
Conditions Helper automatically):

```bash
drush en views_access_conditions -y
```

## What to do next

Nothing runs automatically — the module simply makes a new **Conditions** access
plugin available inside Views. Head to any View and set its **Access** method to
**Conditions** to start using it. See
[How to use it](../index.md#how-to-use-it) for the steps, and remember to
configure at least one condition or the View stays open to everyone.
