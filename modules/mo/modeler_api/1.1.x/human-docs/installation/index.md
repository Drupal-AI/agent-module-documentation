# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12.0`).
- **PHP 8.3 or newer**.
- **At least one Model Owner and one Modeler** — Modeler API does nothing by itself.
  Common choices are ECA (with its `eca_ui` module) as an owner and BPMN.iO
  (`bpmn_io`) as a modeler.
- **Token** (`drupal/token`) is an *optional* suggestion that enables enhanced
  template-token support.

## Install with Composer

From the project root:

```bash
composer require drupal/modeler_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

Because the module needs an owner and a modeler to be useful, install those at the
same time. For example, ECA plus BPMN.iO:

```bash
composer require drupal/modeler_api drupal/eca drupal/bpmn_io -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modeler_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable Modeler API together with your chosen owner and modeler, for example:

```bash
drush en modeler_api eca_ui bpmn_io -y
```

Enabling Modeler API alone has no visible effect — the admin screens and options
only appear once at least one model owner and one modeler are present.

## Verify it worked

Go to **Configuration → Workflow → Modeler API**
(`/admin/config/workflow/modeler_api`). With an owner and a modeler installed, the
settings form lists each owner/modeler combination so you can choose a theme and
storage method — see [Configuration](../configuration/index.md).
