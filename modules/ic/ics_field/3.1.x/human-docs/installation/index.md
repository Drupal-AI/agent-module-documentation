# Installation

## Requirements

- **Drupal 10.5+ or 11** (`core_version_requirement: ^10.5 || ^11`).
- **PHP 7.4 or newer**.
- Core's **Datetime** (`datetime`) and **Token** (`token`) modules — the field
  references a Datetime field for event dates and uses tokens for the summary and
  description. Drupal enables these as dependencies.
- Two PHP libraries, pulled in automatically by Composer:
  - **`eluceo/ical`** (`^0.17.0`) — builds the iCalendar file.
  - **`html2text/html2text`** (`~4.0`) — converts HTML descriptions to plain text
    for calendar clients.

## Install with Composer

From the project root:

```bash
composer require drupal/ics_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`eluceo/ical` and `html2text/html2text` libraries and update any shared
dependencies as needed. Because those libraries are real Composer requirements,
install the module with Composer rather than by copying files.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ics_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ics_field -y
```

## Next step

There is no module settings page to configure. Add a **Calendar download** field
to your event content type as described in the
[overview](../index.md#how-to-use-it).
