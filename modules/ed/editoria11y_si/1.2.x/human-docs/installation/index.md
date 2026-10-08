# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Editoria11y** module (`editoria11y`) — provides the in-page checker
  interface the issues are displayed in.
- The **Key** module (`key`) — stores your Siteimprove API credentials securely.
- An active **Siteimprove subscription with an API key**.

## Install with Composer

From the project root:

```bash
composer require drupal/editoria11y_si -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Editoria11y and Key dependencies as needed.

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
[Configuration](../configuration/index.md) to add your Siteimprove credentials and
schedule the import.
