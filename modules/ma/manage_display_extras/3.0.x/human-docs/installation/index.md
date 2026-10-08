# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [Manage Display](https://www.drupal.org/project/manage_display) module
  (`manage_display`) — this is a required dependency, so install it too. Composer
  will pull it in with the `-W` flag below.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/manage_display_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Manage Display** module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/manage_display_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en manage_display_extras -y
```

This also enables the base **Manage Display** module if it isn't on already.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Manage Display Node Created** | `manage_display_node_created` | Extends the display controls to the node *Authored on* (created) field. |

Enable it only if you need it:

```bash
drush en manage_display_node_created -y
```

## Verify it worked

Go to any content type's **Manage display** screen (**Structure → Content types →
*(your type)* → Manage display**). Open the format options for a string field —
you should see the module's extended title formatter with a field for CSS
classes. See the [overview](../index.md#how-to-use-it) for how to use it.
