# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Options** module (`options`) — each submodule depends on it, and
  Drupal enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/condition_pack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/condition_pack -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Condition Pack is a container project — the actual conditions live in its three
submodules, so enable the one(s) you need rather than the base project.

```bash
drush en condition_pack_ab -y      # A/B testing conditions
drush en condition_pack_date -y    # date / day-of-week conditions
drush en condition_pack_time -y    # time-of-day / timezone conditions
```

You can enable them in any combination. Each submodule is listed under **Condition
Pack** on the **Extend** screen (`/admin/modules`) if you prefer the UI.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **A/B conditions** | `condition_pack_ab` | A condition that shows a block to a random percentage of requests, for simple A/B testing. |
| **Date conditions** | `condition_pack_date` | Conditions to display before a date, on or after a date, or on specific days of the week. |
| **Time conditions** | `condition_pack_time` | Conditions to display within a time-of-day window or to match a timezone. |

## Verify it worked

Go to **Structure → Block layout**, edit any block, and open the **Visibility**
tab. You should see the new condition group(s) for whichever submodules you
enabled.
