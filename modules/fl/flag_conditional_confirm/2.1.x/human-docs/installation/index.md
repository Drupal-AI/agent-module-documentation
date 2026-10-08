# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Flag** module (`flag`) — this module adds a link type to it, and it is
  installed as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_conditional_confirm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_conditional_confirm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_conditional_confirm -y
```

This also enables the Flag module if it isn't already on.

## Verify it worked

Go to **Structure → Flags** (`/admin/structure/flags`) and edit a flag. In the
**Link type** options you should now see **Conditional Confirm Form**. Select it,
configure when the confirmation should appear, and save — then test the flag/unflag
links to confirm the confirmation form shows only when expected.
