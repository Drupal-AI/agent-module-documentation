# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- **Date popup** (`date_popup`) — the declared module dependency.
- As documented by the module, it also works with **Token**, **Views**, and
  **Views data export** — Token for template placeholders, and Views (plus Views
  data export) for the SMS log/reporting screens. Install these to get the full
  feature set.
- An **SMS gateway account** (for example InterMobcom, BulkSMS, PROCONTEXT, or
  EMOTION TRADING) for the credentials you'll enter in the API settings.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/smssystem -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in dependencies as
needed. To be sure the companion modules are present, you can require them
explicitly:

```bash
composer require drupal/smssystem drupal/token drupal/views_data_export -W
```

(Views is part of Drupal core.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smssystem -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smssystem -y
```

## Next step

Enter your gateway credentials and set up templates — see
[Configuration](../configuration/index.md). Consider turning on **Test mode**
first so you don't spend money while you get things working.
