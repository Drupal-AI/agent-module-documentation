# Installation

## Requirements

- **Drupal 10.3+ or 11.1+** (`core_version_requirement: ^10.3 || ^11.1`).
- The **State Machine** module (`state_machine`) — a required dependency. Composer
  pulls it in automatically, and Drupal enables it as a dependency when you turn
  this module on.
- This is an early (alpha) release; test before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/state_machine_automated_transition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required State Machine module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/state_machine_automated_transition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en state_machine_automated_transition -y
```

Drupal enables the required State Machine module automatically as a dependency.

## Verify it worked

Confirm State Machine is present and enabled, then set up (or use an existing)
State Machine workflow with transitions and guards. The automated transitions this
module applies operate on those workflows, always honoring State Machine's
configured transitions and guards.
