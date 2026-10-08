# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Simplenews** module (`simplenews`) — this is the whole point of the module,
  and it must be installed and enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/simplenews_resend -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Simplenews if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplenews_resend -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplenews_resend -y
```

Drupal enables Simplenews alongside it if needed.

## Verify it worked

Open an existing, already-sent Simplenews newsletter issue and confirm you can now
reset its sent status back to "not sent". That reset action is what the module adds;
there is no separate settings page.
