# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Checklist API** module (`checklistapi`) — this module
  depends on it to store completion state and render the checklist. It is pulled
  in automatically by Composer.
- A working **outbound HTTP connection**, because the checklist items are
  fetched from The A11Y Project when the list is built.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/a11yproject_checklist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Checklist API
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/a11yproject_checklist -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en a11yproject_checklist -y
```

Enabling it also enables Checklist API if it is not already on. The checklist
then appears at **Configuration → Development → A11Y Project Checklist**
(`/admin/config/development/a11y-project-checklist`). See
[Configuration](../configuration/index.md) for how to use it and set
permissions.
