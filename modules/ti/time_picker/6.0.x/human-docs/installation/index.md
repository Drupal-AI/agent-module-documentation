# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/time_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/time_picker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en time_picker -y
```

## Verify it worked

Go to **Structure → Content types → *any type* → Manage fields → Add field**. The
field-type list should now offer the **Time** and **Time range** picker fields.
Add one, then edit a piece of content — you should see the styled time picker
widget when you enter a value.
