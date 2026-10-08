# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Field** module (`field`) — enabled automatically as a
  dependency; you need an email field to apply the formatter to.

No additional modules or external libraries are required.

> **Note:** This project's security advisory coverage is marked *not covered* by
> the Drupal Security Team.

## Install with Composer

From the project root:

```bash
composer require drupal/email_hidden_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_hidden_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_hidden_formatter -y
```

## Verify it worked

On a content type's **Manage display** page, set an email field's format to
**Email Hidden** (see the [main guide](../index.md)) and save. View a piece of
content with that field filled in — the address should be hidden, with a control
to reveal it on click.
