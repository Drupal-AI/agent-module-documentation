# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`) enabled — this is the only dependency,
  and Drupal enables it automatically as a dependency when you turn on Datetime
  Now.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_now -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datetime_now -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_now -y
```

That's all it takes — there is nothing to configure. The **Now** button appears
immediately on every Date and time and Datetime Range widget across your site.

## Verify it worked

Edit any content that has a Date/time field using the **Date and time** widget. A
**Now** button should appear next to the date and time inputs; clicking it fills in
the current date and time.
