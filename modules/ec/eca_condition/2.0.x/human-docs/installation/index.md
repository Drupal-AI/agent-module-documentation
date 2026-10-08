# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **ECA** base module (`eca`) — installed automatically as a dependency when
  you require this module with Composer.

There are no third‑party PHP library or Composer requirements. You will, in
practice, also want one of ECA's modelling tools installed (BPMN.iO or the ECA
Classic Modeller) so you have a UI in which to build models.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the ECA base
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_condition -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_condition -y
```

Enabling `eca_condition` also enables `eca` if it wasn't already on.

## Verify it worked

Open an ECA model at **Configuration → Workflow → ECA** and add a condition to a
gateway. The Drupal Condition plugins (request path, user role, content type, and
any others provided by installed modules) should now appear in the list of
available conditions.
