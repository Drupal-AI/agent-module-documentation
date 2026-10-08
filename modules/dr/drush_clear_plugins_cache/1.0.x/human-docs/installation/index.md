# Installation

## Requirements

- **Drupal 8.7.7+, 9, or 10** (`core_version_requirement: ^8.7.7 || ^9 || ^10`).
- The **Devel** module (`devel`) — this is the module's only dependency, and its
  presence marks the tool as development-only. Composer installs it for you.
- **Drush**, since the module's whole purpose is a Drush command.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_clear_plugins_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Devel and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_clear_plugins_cache -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_clear_plugins_cache -y
```

Drupal enables Devel automatically as a dependency. Enable this on a **development
environment**; disable both it and Devel on production.

## Verify it worked

After enabling, run:

```bash
drush pmcc
```

If Drush clears the plugin-manager caches (or reports that it has), the command is
registered and working. See the [main guide](../index.md) for the full command
options.
