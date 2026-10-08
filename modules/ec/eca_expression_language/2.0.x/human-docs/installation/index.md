# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **ECA** base module (`eca`) — installed automatically as a dependency.

The Symfony Expression Language component this module relies on ships with Drupal
core, so there are no extra third‑party library requirements. You will also want
one of ECA's modelling tools (BPMN.iO or the ECA Classic Modeller) installed so you
have a UI in which to build models.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_expression_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the ECA base
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_expression_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_expression_language -y
```

This also enables `eca` if it is not already on.

## Verify it worked

Open an ECA model at **Configuration → Workflow → ECA**, add a condition to a
gateway, and confirm **Expression Language Condition** appears in the list of
available conditions. Enter a simple expression (for example `[user:uid] == 1`) to
confirm it evaluates.
