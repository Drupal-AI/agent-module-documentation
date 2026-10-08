# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **`simshaun/recurr`** PHP library (`^5`) — a Composer dependency that powers
  recurring-event rules. Composer installs it for you automatically.
- Core's **Datetime** (`datetime`) and **Options** (`options`) modules — the only
  module dependencies, and Drupal enables them for you when you turn Smart Date on.

The **Multiple Fields Remove Button** module is only *suggested* (it gives editors
a button to remove unwanted multi-value rows); install it separately if you want
that convenience.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`simshaun/recurr` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_date -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_date -y
```

Once enabled, the `smartdate` field type and its default formats are available.
Nothing appears on your content until you add a Smart Date field to a content type
— see [Configuration](../configuration/index.md).

## Submodule — Smart Date Recurring

Smart Date ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Smart Date Recurring** | `smart_date_recur` | RRULE-based recurring events — repeat rules, per-instance overrides, cancelling a single occurrence, and rescheduling future instances, plus management UIs. Powered by the `simshaun/recurr` library. It also adds its own permissions (*make smart dates recur*, *reschedule*, *cancel* instances). |

Enable it when you need repeating events:

```bash
drush en smart_date_recur -y
```

## Migrating existing date fields

If you already have core `datetime`/`daterange` fields, Smart Date provides a Drush
command to migrate them to Smart Date fields — see the sibling
[`agent/`](../agent/start.md) docs (Drush section) for the command details.

## Verify it worked

Log in as an administrator and go to **Configuration → Regional and language →
Smart date formats** (`/admin/config/regional/smart-date`). If you see the list of
formats (default, compact, date only, time only), the module is installed and
ready to use.
