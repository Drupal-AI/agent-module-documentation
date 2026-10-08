# Installation

## Requirements

- **Drupal 11.1+** (`core_version_requirement: ^11.1`).
- The **State Machine** module (`state_machine`) — a required dependency. Composer
  pulls it in automatically, and Drupal enables it as a dependency when you turn
  this module on.
- This is an early (alpha) release; test before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/state_machine_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required State Machine module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/state_machine_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en state_machine_ui -y
```

Drupal enables the required State Machine module automatically as a dependency.

## Verify it worked

Log in as an administrator and grant the module's workflow-management permissions
at **People → Permissions** (`/admin/people/permissions`). You should then be able
to manage State Machine workflow groups, states, and transitions through the admin
UI rather than only in code and configuration.
