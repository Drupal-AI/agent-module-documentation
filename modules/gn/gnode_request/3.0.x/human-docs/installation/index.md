# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`) and its **Group Node** submodule (`gnode`) — the
  foundation this module extends.
- The **State Machine** module (`state_machine`) — drives the request's
  approve/reject workflow.

Composer will pull these in for you when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/gnode_request -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Group, Group Node,
and State Machine and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gnode_request -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gnode_request -y
```

Drupal will enable `group`, `gnode`, and `state_machine` at the same time because
they are dependencies.

## Verify it worked

Confirm the module is enabled (**Extend**, or `drush pml | grep gnode_request`),
and that your **Group** types are in place. You can then enable the request
behaviour on a group type and grant the request/approval group permissions — see
"How to use it" on the [overview page](../index.md).
