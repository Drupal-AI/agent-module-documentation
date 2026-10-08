# Installation

## Requirements

Add to Cal needs:

- **Drupal 9.2+, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`), which is part of standard Drupal and is
  enabled automatically as a dependency.
- The **`spatie/calendar-links`** PHP library (`^1.7`), which does the actual
  calendar-link generation. Composer installs it for you when you require the
  module below — there's nothing to download by hand.

Optional but recommended:

- The **Token** module (`drupal/token`) — suggested, not required. Installing it
  enables the token UI on the formatter's title/location/description settings and
  the `addtocal-url` field token.

## Install with Composer

From the project root:

```bash
composer require drupal/addtocal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and pulls in the required `spatie/calendar-links` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addtocal -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

To also add the recommended Token module:

```bash
composer require drupal/token -W
drush en token -y
```

## Enable the module

```bash
drush en addtocal -y
```

Enabling it makes the two **Add to Cal** formatters available on date fields. There
is no settings page and no configuration step — you select and configure the
formatter per field on **Manage display**.

## Verify it worked

Go to the **Manage display** screen of a content type that has a supported date
field (for example an Event type with a `datetime` field), and confirm that **Add
to Cal** and **Add to Cal grouped button** appear as format options for that field.
See the [how-to-use section on the overview page](../index.md#how-to-use-it) for
what to do next.
