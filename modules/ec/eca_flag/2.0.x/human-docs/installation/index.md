# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **ECA** base module (`eca`, `^2.0 || ^3.0`).
- The **Flag** module (`flag`, `^4.0 || ^5.0`).

Both dependencies are pulled in automatically when you require this module with
Composer. You will also want one of ECA's modelling tools (BPMN.iO or the ECA
Classic Modeller) installed.

> **Flag patches:** because Flag has historically not had a fully stable release,
> older setups needed two patches to Flag when adopting this module (ECA
> integration — already included in Flag 8.x-4.x-dev — and a token
> re-implementation). Check the module's project page for the current patch guidance
> against the Flag version you run.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_flag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and Flag and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_flag -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_flag -y
```

This also enables `eca` and `flag` if they are not already on.

## Verify it worked

Define a flag at **Structure → Flags**, then open an ECA model at **Configuration →
Workflow → ECA**. Adding an event should reveal the *Flag* / *Unflag* events, and
adding a condition should reveal the "is entity flagged" condition provided by this
module.
