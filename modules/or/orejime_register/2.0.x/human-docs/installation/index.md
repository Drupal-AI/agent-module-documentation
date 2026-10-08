# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Orejime** module (`orejime`), version `^3` — this is required, and it
  provides the consent manager whose decisions this module records.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/orejime_register -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Orejime `^3` and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orejime_register -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orejime_register -y
```

That's the whole setup — as the project puts it, "there is no step 2." Once enabled,
consent responses are stored automatically. Enabling it also enables Orejime if it is
not already on.

## Verify it worked

Make sure Orejime's consent banner is working, then accept or decline a service as a
visitor. Log in as an administrator and go to **Reports → Orejime Register**
(`/admin/reports/orejime-register/list`) — you should see the consent decision
recorded. The same page offers the purge options you'll use to enforce your retention
policy.
