# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** system (present in any standard Drupal install).

There are no third-party Composer or PHP library requirements declared. Note that
the current release is a **beta** (`1.0.0-beta1`) — test it before relying on it
in production.

## Install with Composer

From the project root:

```bash
composer require drupal/lc_color_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lc_color_picker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lc_color_picker -y
```

## Verify it worked

Go to any bundle's **Manage fields → Add field** and confirm the LC Color Picker
field type is available. Add it to a content type, check the widget on **Manage
form display**, then edit a piece of content — the color field should render as a
visual picker supporting solid colors and gradients.
