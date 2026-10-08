# Installation

## Requirements

Group Join Link needs Views and the Group module:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) — the link is provided as a Views field.
- The **Group** module (`group`).

There are no third‑party Composer or PHP library requirements. This 3.x release
is built for Group 3.0.

## Install with Composer

From the project root:

```bash
composer require drupal/group_join_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_join_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_join_link -y
```

Core Views and the Group module are enabled as dependencies if they are not
already on.

## Submodules

Group Join Link ships no submodules.

## Verify it worked

Edit a View that lists groups (**Structure → Views**) and confirm the group
**join / leave link** field is available to add. Once placed, view the listing as
a user who is eligible to join a group and confirm the join link appears — and
that it does not appear where Group's rules would not permit joining.
