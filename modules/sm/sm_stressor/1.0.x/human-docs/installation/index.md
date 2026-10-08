# Installation

## Requirements

- **Drupal 10.6+ or 11.3** (`core_version_requirement: ^10.6 || ^11.3`).
- **Symfony Messenger** (`sm`) and **Message Scheduler** (`sm_scheduler`) —
  pulled in by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_stressor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `sm` and
`sm_scheduler` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_stressor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_stressor -y
```

Note this module is **not covered by the security advisory policy**, and it is
intended to place real load on your infrastructure — enable it deliberately and
be prepared for the load you generate to affect the running system.
