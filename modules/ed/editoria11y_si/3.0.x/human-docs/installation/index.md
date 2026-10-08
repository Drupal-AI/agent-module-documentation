# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Editoria11y** module (`drupal/editoria11y` `^3.0`) — provides the in-page
  checker interface. This 3.0.x release specifically requires Editoria11y 3.x.
- The **Key** module (`drupal/key` `^1.22`) — stores your SiteImprove credentials
  securely.
- An active **SiteImprove subscription with an API key**.
- **Recommended:** the **Purge** module (`drupal/purge`). The import queue worker
  references Purge's services, but Purge is *not* declared as a dependency —
  install it if the queue worker fails to instantiate during cron processing.

## Install with Composer

From the project root:

```bash
composer require drupal/editoria11y_si -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Editoria11y and Key dependencies as needed. If you hit the Purge issue, add it
explicitly:

```bash
composer require drupal/purge -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/editoria11y_si -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editoria11y_si -y
```

Drupal will enable Editoria11y and Key automatically as dependencies if they are
not already on.

## Verify it worked

Log in as an administrator and open **Configuration → Content authoring →
Editoria11y → SI** (`/admin/config/content/editoria11y/si`). If the settings form
loads, installation succeeded. Nothing is imported yet — continue to
[Configuration](../configuration/index.md).
