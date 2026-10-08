# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only dependency, enabled
  automatically when you turn on this module.
- If you import from a remote calendar (e.g. a Google Calendar feed), outbound
  network access from your server to that URL.

There are no third‑party Composer or PHP library requirements.

> **Version note:** this release line is `8.x` (a `-dev` branch) and the module is
> minimally maintained. Test your migration on a copy before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_ical -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_source_ical -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_ical -y
```

## Verify it worked

Write a migration that uses this iCal source plugin, pointed at a small test
calendar or `.ics` file, then run:

```bash
drush migrate:status
```

The row count should reflect the number of events in the calendar. Run
`drush migrate:import` to bring the events in, and check that the mapped event
fields (dates, summary, description) populated correctly.
