# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: >=11.1`).
- **PHP 8.3 or newer**.
- The following modules, which Composer installs as dependencies:
  - **CRM** (`crm`) — the contact framework this module builds on.
  - **Duration Field** (`duration_field`).
  - **Datetime Range** (core `datetime_range`).
- No additional third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/crm_membership -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update CRM,
Duration Field, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crm_membership -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crm_membership -y
```

Enabling the module also enables CRM and Duration Field if they are not already on.

## Make sure cron runs

Automatic membership expiration depends on cron: a cron job finds memberships whose
periods have all lapsed and queues them to be marked expired. Confirm your site runs
cron regularly (for example via `drush cron` on a schedule) so memberships expire when
they should.

## Verify it worked

Go to **Structure → CRM → Membership Types**
(`entity.crm_membership_type.collection`). If the membership-types listing loads, the
module is installed and ready to configure — see
[Configuration](../configuration/index.md).
