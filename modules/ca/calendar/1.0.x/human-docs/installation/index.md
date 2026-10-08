# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** (`views`) and **Datetime** (`datetime`) modules — Views draws
  the calendar and Datetime provides the date field support. Enabled
  automatically as dependencies.
- **Views Templates** (`drupal/views_templates`, `^1.2`) — powers the "Add from
  template" builder that generates a ready-made calendar view. Pulled in by
  Composer.
- The bundled **Calendar Datetime** submodule (`calendar_datetime`) — required by
  the main module (see below).

> **Beta release.** Calendar 1.0.x is a beta. Test it before relying on it in
> production, and enable Views result/render caching in each calendar display's
> *Advanced* settings, since calendars are expensive to render.

## Install with Composer

From the project root:

```bash
composer require drupal/calendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Views Templates.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/calendar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar -y
```

## Submodule — Calendar Datetime

The project bundles one submodule, which the main module depends on:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Calendar Datetime** | `calendar_datetime` | Provides the **Calendar Current date** argument-default plugin, so a calendar opens on today's date when no period is given in the URL. |

Because `calendar` depends on it, Drupal enables `calendar_datetime` automatically
when you enable Calendar.

## Optional — recurring dates

If your content uses recurring dates, the module suggests adding **Date Recur**:

```bash
composer require drupal/date_recur -W
drush en date_recur -y
```

This is optional and only needed for recurring-date functionality.

## Next steps

There is nothing to configure to get started beyond building a calendar view. Go
to **Structure → Views**, use **"Add from template"**, and pick your date field —
see the [overview](../index.md#how-to-use-it) for the walkthrough.
