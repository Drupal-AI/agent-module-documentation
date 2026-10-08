# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`). This release targets
  a recent Drupal 11 minor only — **there is no Drupal 10 support**.
- Core's **System**, **User**, and **Views** modules.
- Three contrib modules, pulled in as Composer dependencies:
  - **Entity API** (`drupal/entity`, `^1.0`)
  - **State Machine** (`drupal/state_machine`, `^1.0`) — drives the workflow state.
  - **Token** (`drupal/token`, `^1.0`)

## Install with Composer

From the project root:

```bash
composer require drupal/log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity API, State
Machine, Token, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/log -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en log -y
```

Drupal will enable the Entity, State Machine, and Token dependencies alongside it.

## Verify it worked

After enabling, define at least one **log type** under Structure and grant the
relevant permissions on **People → Permissions** (see the
[overview page](../index.md)). Then create a log of that type and confirm you can
move it through its workflow state and see it in the Log collection.
