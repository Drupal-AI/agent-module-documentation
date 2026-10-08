# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **Datetime** (`datetime`) and **Options** (`options`) — enabled in
  a standard install.
- The contributed **Entity API** module (`entity`) and the **Address** module
  (`address`).
- A **DonorPerfect account with XML API access enabled**, and API credentials —
  preferably an **API key** provided by your DonorPerfect representative (a
  username and password also work, but an API key is preferred).

There are no additional third‑party PHP library requirements beyond what Composer
pulls in for the module and its dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/donorperfect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity API,
Address, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/donorperfect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module (and, when you need them, the Donor, Gift, Contact, and
Other Info submodules that build on it):

```bash
drush en donorperfect -y
```

## Verify it worked

Go to **`/admin/donorperfect/settings`** and confirm the settings form loads.
Once you have entered valid API credentials there and populated the metadata
cache (see [Configuration](../configuration/index.md)), the DonorPerfect fields
you select will become available when building Views or loading entities.
