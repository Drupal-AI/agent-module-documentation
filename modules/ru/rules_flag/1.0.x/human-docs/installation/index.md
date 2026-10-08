# Installation

## Requirements

Rules Flag is glue between several modules, so it needs them all present:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1||^10||^11`).
- The **Flag** module (`flag`).
- The **Rules** module (`rules`).
- The **Job Scheduler** module (`job_scheduler`) — used by the scheduling‑related
  action.
- No third‑party Composer libraries or PHP extensions beyond what those modules need.

## Install with Composer

From the project root:

```bash
composer require drupal/rules_flag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Flag, Rules, and Job Scheduler if they aren't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rules_flag -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rules_flag -y
```

Enabling it also imports the bundled **example rules** in a disabled state, ready for
you to enable and adapt.

## Verify it worked

Go to **Configuration → Workflow → Rules** (`/admin/config/workflow/rules`). You
should see the imported example rules listed (disabled). When you create or edit a
reaction rule and add an event, the flag/unflag events (for example *After flagging a
content item*) should be available to choose.
