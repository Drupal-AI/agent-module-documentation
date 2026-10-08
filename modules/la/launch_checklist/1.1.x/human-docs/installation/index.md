# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Checklist API** module (`checklistapi`) — Launch Checklist is built on it
  and depends on it. Composer pulls it in automatically as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/launch_checklist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in Checklist API alongside Launch Checklist.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/launch_checklist -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enabling Launch Checklist will also enable Checklist API if it is not already on:

```bash
drush en launch_checklist -y
```

## Verify it worked

Log in as an administrator and open the **Configuration** area — the **Launch
Checklist** should now appear among your checklists, with its 14 sections ready to
work through. See [Configuration](../configuration/index.md) for how to use it.
