# Installation

## Requirements

ECA Classic Modeler needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **ECA** module (`drupal/eca`, version `^1 || ^2 || ^3`) — this is the engine
  the Classic Modeler authors models for. Installing the Classic Modeler with
  Composer pulls ECA in as a dependency.

There are no third-party libraries. Two optional modules improve the experience:
**Select2** (`drupal/select2`) for nicer plugin pickers, and **Token**
(`drupal/token`) for a token browser.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_cm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this is what pulls in the ECA engine.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_cm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable ECA and the Classic Modeler together (Drush enables the `eca` dependency
automatically, but you can name both to be explicit):

```bash
drush en eca eca_cm -y
```

## Grant access

Authoring ECA models is gated by ECA's **administer eca** permission (the Classic
Modeler does not add a permission of its own). Grant it on **People → Permissions**
(`/admin/people/permissions`) to the roles that should be allowed to build
automations.

## Next steps

Once enabled, go to **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`) and click **Add new Classic model** to start
building. See the [overview](../index.md) for the full model-building workflow.
