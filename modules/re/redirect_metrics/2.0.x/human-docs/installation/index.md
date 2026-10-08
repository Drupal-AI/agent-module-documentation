# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contrib **Redirect** module (`drupal/redirect`) — this module tracks *its*
  redirects, so it is essential. Redirect metrics relies on the header that Redirect
  sets on each redirect response to know when to count a hit.
- Core's **Views** module (`views`, part of Drupal core and enabled on most sites) —
  the two reports are built as Views.

There are no third-party Composer or PHP library requirements, and the module adds
no permissions or settings of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_metrics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Redirect module
(if it isn't already present) and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_metrics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_metrics -y
```

This also enables the Redirect and Views modules if they aren't already on. Enabling
Redirect metrics adds the hit-count and last-access fields to your redirects and
registers the two report tabs.

## That's it

There is no configuration step — counting begins immediately, and the **Popular
redirects** and **Stale redirects** tabs appear on the redirect admin screen. See
[How to use it](../index.md#how-to-use-it) in the main guide to read and tune the
reports. (Existing redirects created before you installed the module start counting
from their next hit.)
