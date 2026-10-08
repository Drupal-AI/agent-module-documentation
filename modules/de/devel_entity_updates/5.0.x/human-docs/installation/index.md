# Installation

> **Development environments only.** Never install or enable this module in
> production. It applies entity schema changes directly, which released code must do
> through `hook_update_N()` / `hook_post_update_NAME()` instead.

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Devel** (`devel`) module — a dependency.
- **Drush 12 or 13** — the module's functionality is a Drush command.

## Install with Composer

Because this is a development tool, require it as a dev dependency from the project
root:

```bash
composer require --dev drupal/devel_entity_updates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Devel and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/devel_entity_updates -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_entity_updates -y
```

There is nothing to configure — the module simply registers its Drush command.

## Verify it worked

Run the command with no pending changes:

```bash
drush entup
```

You should see either a summary of pending entity/field updates to confirm, or the
message *"No entity schema updates required"* if there's nothing to apply. Either
response confirms the command is registered and working.
