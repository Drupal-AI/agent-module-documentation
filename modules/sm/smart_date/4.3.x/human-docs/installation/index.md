# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Datetime** and **Options** modules (enabled automatically as
  dependencies).
- The **`simshaun/recurr`** PHP library (`^5`), installed by Composer — used for
  recurring dates.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `simshaun/recurr`
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_date -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_date -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Smart Date Recurring** | `smart_date_recur` | RRULE-based recurring events, with per-instance overrides, cancellations, rescheduling of future instances, and management UIs. Stores each instance as an ordinary field delta for easy Views integration. Enable it only if you need repeating dates. |

To add recurring support:

```bash
drush en smart_date_recur -y
```

## Migrating existing date fields

If you already have core `datetime` or `daterange` fields, Smart Date provides a
Drush command to migrate them to Smart Date fields — see the module's
[Drush documentation](../../agent/drush/commands.md) for the exact command and
options. You can also keep using core date fields and simply apply Smart Date's
widget and formatter to them for the improved UX and display, without changing
storage.

## Verify it worked

Add a **Smart date** field to any content type
(**Structure → Content types → *(type)* → Manage fields → Add field**). If
**Smart date** appears in the field-type list, the module is installed. You can also
visit **Configuration → Regional and language → Smart date formats**
(`/admin/config/regional/smart-date`) to see the bundled display formats.
