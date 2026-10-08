# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **Webform** (`webform`) — provides the forms these elements live on.
- **CMRF Core** (`cmrf_core`) — provides the CiviMRF connection to CiviCRM.
- A **CiviCRM** backend reachable over a configured CiviMRF connection, with a
  data processor or search to reference.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmrf_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform, CMRF
Core, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cmrf_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmrf_reference -y
```

## Verify it worked

Edit any Webform and open the element picker — you should now see **CMRF
Reference** and **CMRF Radios** as available element types. See the "How to use
it" section of the [guide](../index.md) for configuring an element against your
CiviCRM data processor.
