# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[ECA](https://www.drupal.org/project/eca)** module (`eca`) — this is the
  module whose workflows you model as BPMN.
- The standalone **Camunda desktop application** (the BPMN Modeler) on your own
  machine, where you draw the diagrams.

## Install with Composer

From the project root:

```bash
composer require drupal/camunda -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the ECA dependency and updates any
shared ones as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/camunda -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en camunda -y
```

Drupal will enable `eca` at the same time if it isn't already on. Once enabled, use
the import/export between Drupal and the desktop Camunda application to author your
ECA models — see [How to use it](../index.md#how-to-use-it).
