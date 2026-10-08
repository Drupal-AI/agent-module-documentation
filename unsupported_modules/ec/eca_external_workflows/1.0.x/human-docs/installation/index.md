# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **ECA** base module (`eca`).
- The **Key** module (`key`) — used to store webhook secrets and API credentials
  securely.

Both dependencies are pulled in automatically when you require this module with
Composer. You will also want one of ECA's modelling tools (BPMN.iO or the ECA
Classic Modeller) installed, plus outbound HTTPS access to whichever external
platform you target.

> **Heads-up:** this module is an early (1.0.x, alpha) release and its maintenance
> status is currently listed as *unsupported / obsolete*. Evaluate it carefully
> before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_external_workflows -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and the Key
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_external_workflows -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_external_workflows -y
```

This also enables `eca` and `key` if they are not already on. Then enable the
provider module for the platform you use — for example the included Pipedream
provider (**ECA External Workflows Pipedream**).

## Verify it worked

Open an ECA model at **Configuration → Workflow → ECA**, add an action, and confirm
the **Execute External Workflow** action appears in the list. Before going live,
configure your credentials via the Key module (see the main guide) and send a test
payload to confirm the external workflow fires.
