# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **CMRF Core** (`cmrf_core`) — provides the CiviMRF connection to CiviCRM. You
  must have a working connection configured here before the Form Processor can
  reach your CRM.
- **Webform** (`webform`) — the forms this module submits to CiviCRM.
- A **CiviCRM** backend (local or remote) with the **Form Processor** extension
  and at least one Form Processor defined.

There are no additional PHP library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/cmrf_form_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform, CMRF
Core, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cmrf_form_processor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmrf_form_processor -y
```

## Submodules

Two optional submodules ship with the project — enable only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Form Processor Display** | `cmrf_form_processor_display` | Display helpers for Form Processor output. |
| **Form Processor Mollie** | `cmrf_form_processor_mollie` | Mollie payment handling for Form Processor submissions. Enabling it brings payment-security considerations. |

For example:

```bash
drush en cmrf_form_processor_mollie -y
```

## Verify it worked

The module has no page of its own. To confirm it is ready, open a Webform's
**Handlers** settings and check that the CiviMRF Form Processor handler is
available to add. Then submit a test entry and confirm it reaches CiviCRM. See
the "How to use it" section of the [guide](../index.md) for the full wiring
steps.
