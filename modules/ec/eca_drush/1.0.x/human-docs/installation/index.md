# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- The **ECA** base module (`eca`) — installed automatically as a dependency.
- **Drush** available in your environment (it is part of a standard Drupal
  Composer project and of DDEV).

There are no third‑party PHP library requirements. You will also want one of ECA's
modelling tools (BPMN.iO or the ECA Classic Modeller) installed so you have a UI
in which to build models.

> **Heads-up:** this module is an early (1.0.x, alpha) release and is **not covered
> by Drupal's security advisory policy**. Evaluate it accordingly before production
> use.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_drush -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the ECA base
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_drush -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_drush -y
```

This also enables `eca` if it is not already on.

## Verify it worked

Open an ECA model at **Configuration → Workflow → ECA**, add an action, and confirm
the Drush command action provided by this module appears in the list of available
actions.
