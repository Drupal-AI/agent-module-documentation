# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`). Use this
  **3.x** release with Group 3.x.
- The **[Scheduled Transitions](https://www.drupal.org/project/scheduled_transitions)**
  module (`scheduled_transitions`).

Both are enabled automatically as dependencies. The maintainers also **strongly
recommend** installing the **Group Content Moderation** module, though it is not a
hard requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/group_scheduled_transitions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Group and
Scheduled Transitions and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_scheduled_transitions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_scheduled_transitions -y
```

## Verify it worked

Open a group type's **permissions** page and confirm you can see the new **view
scheduled transitions** and **add scheduled transitions** permissions. Grant them
to a group role, then check that a member with that role can schedule a moderation
state change on the group's content.
