# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`) — the module's own
  notes say Drupal 10.x or higher.
- **PHP 8.1 or higher**.
- Core's **System** module (`system`), which is always present.
- No third-party Composer or PHP library requirements.

Note that this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_404_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_404_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_404_logger -y
```

That is all — the module requires **no configuration** and begins logging 404s
immediately.

## Verify it worked

Visit any non-existing URL, such as `/test-404`, then go to **Reports → Simple
404** (`/admin/reports`). The path you just requested should appear with a hit
count and a last-accessed time.
