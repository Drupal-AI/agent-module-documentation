# Installation

## Requirements

Group Notify works with the Group module's Group Node plugins:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Group Node** module (`gnode`) — this ships with the Group project and is
  the module whose content plugins Group Notify hooks into. Enabling `gnode` pulls
  in the Group module.

There are no third‑party Composer or PHP library requirements. If you have very
large groups, the optional **Queue Mail** (`queue_mail`) module can be added
separately to smooth out sending — see below.

## Install with Composer

From the project root:

```bash
composer require drupal/group_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Group) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_notify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_notify -y
```

Group Node (`gnode`) and the Group module are enabled as dependencies if they are
not already on.

## Submodules

Group Notify ships no submodules.

## Optional: smooth out large sends

If saving a group node becomes slow because a group has many members to email,
install and enable the Queue Mail module to move sending into a queue:

```bash
composer require drupal/queue_mail -W
drush en queue_mail -y
```

## Verify it worked

After enabling, go to a group type's **Set available content** page (**Groups →
Group types → *(your group type)*** → *Set available content*) and confirm that
the Group Node content plugins offer a **Notify group members** option when you
install or configure them. Then follow [Configuration](../configuration/index.md)
to switch it on.
