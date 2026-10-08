# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- The **[Layout Builder Styles](https://www.drupal.org/project/layout_builder_styles)**
  module (`drupal/layout_builder_styles` `^2.1`) — the module whose styles you are
  adding conditions to. (Layout Builder Styles in turn needs core's Layout Builder.)
- The **[Conditions Helper](https://www.drupal.org/project/conditions_helper)**
  module (`drupal/conditions_helper` `^1.0`) — provides the condition-building form
  and evaluator.

Composer pulls both dependencies in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_styles_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Layout Builder
Styles and Conditions Helper and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lb_styles_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drupal will offer to enable Layout
Builder Styles and Conditions Helper automatically):

```bash
drush en lb_styles_conditions -y
```

## What to do next

The module adds a **Condition restrictions** section to your Layout Builder Style
add/edit forms. Head to **Configuration → Content authoring → Layout Builder
Styles** and edit a style to start attaching conditions — see
[How to use it](../index.md#how-to-use-it) for the steps.
