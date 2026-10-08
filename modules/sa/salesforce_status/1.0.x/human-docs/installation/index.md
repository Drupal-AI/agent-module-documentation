# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **The Salesforce Suite** (`salesforce`), configured and authorized to your org —
  it owns the connection and credentials that Salesforce Status monitors.

There are no third-party PHP library requirements. The module ships one optional
submodule, **Salesforce Status Mail** (`salesforce_status_mail`), for email
notifications.

## Install with Composer

From the project root:

```bash
composer require drupal/salesforce_status -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the Salesforce Suite
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/salesforce_status -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en salesforce_status -y
```

## Optional: email notifications

To be emailed when the connection fails or recovers, enable the submodule as well:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Salesforce Status Mail** | `salesforce_status_mail` | Sends email notifications on Salesforce connection status changes, by subscribing to the module's events. It also serves as an example of how to react to those events in your own code. |

```bash
drush en salesforce_status_mail -y
```

Check the submodule's own README for its configuration, and set the recipients
appropriately — status emails can include connection detail.

## Verify it worked

With the Salesforce Suite connected, Salesforce Status begins checking the
connection automatically. Confirm it is active on **Reports → Status report**
(`/admin/reports/status`), where the module reports whether Salesforce is
available.
