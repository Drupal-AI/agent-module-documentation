# Installation

## Requirements

ECA Webform is a bridge module, so it needs both sides of the bridge:

- **Drupal 10.4+ or 11** (`core_version_requirement: ^10.4 || ^11`).
- **PHP 8.1 or newer**.
- **[ECA](https://www.drupal.org/project/eca)** `^2.0 || ^3.0` (`eca`).
- **[Webform](https://www.drupal.org/project/webform)** `^6.2 || ^6.3` (`webform`).

Composer pulls ECA and Webform in automatically when you require this module. To draw
workflows visually you will typically also want ECA's modeller submodule and a BPMN
modeller — see the ECA module's own documentation for that setup.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in ECA, Webform, and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_webform -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_webform -y
```

Drupal enables `eca` and `webform` at the same time if they are not already on.

Once enabled, there is nothing to configure here — the module's events and actions
simply become available inside the ECA modeller. See
[How to use it](../index.md#how-to-use-it) for the workflow.
