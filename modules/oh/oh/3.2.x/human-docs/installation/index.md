# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- The **Date Recur** module (`date_recur`) — required. OH uses Date Recur to express
  recurring opening hours and exceptions.

There are no other third‑party Composer libraries or special PHP extensions to
install beyond what Date Recur brings.

## Install with Composer

From the project root:

```bash
composer require drupal/oh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will pull in Date Recur if it isn't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oh -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oh -y
```

This also enables Date Recur if it isn't already on.

## Submodules — enable only what you need

OH ships three optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Date Recur OH Field** | `date_recur_oh_field` | The field integration — turn a Recurring Date field into opening hours on an entity bundle. This is the usual starting point. |
| **OH Regular** | `oh_regular` | Support for regular (weekly) opening hours. |
| **OH Review** | `oh_review` | A review/overview of the computed opening hours. |

For example, to add the field integration:

```bash
drush en date_recur_oh_field -y
```

## Verify it worked

Add a **Recurring Date** field for opening hours to a location bundle, configure its
display, and confirm the opening times render on the entity. See the
[guide overview](../index.md) for the full workflow.
