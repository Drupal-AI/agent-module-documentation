# Installation

## Requirements

- **Drupal core `^10 || ^11`**.
- A working **Behat/Mink** setup for the project — Behat UI is a front-end for
  running Behat tests, so the underlying testing tooling needs to be available in
  the environment.

There are no other module dependencies.

> **Install this in a development or CI environment only.** Behat UI can run tests
> that create content and log in as users; it should not be enabled on a
> production site.

## Install with Composer

From the project root:

```bash
composer require drupal/behat_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Consider requiring it as a dev-only dependency
(`composer require --dev …`) so it never ships to production.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/behat_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en behat_ui -y
```

After enabling, confirm the test-running interface is restricted to trusted
developer/administrator roles, and keep the module disabled in production — see
the [overview](../index.md#how-to-use-it).
