# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.3.** The module's `.info.yml` declares `php: 8.3`, while `composer.json`
  only asks for `>=8.1`. The stricter value in the info file is what Drupal
  enforces at install time, so plan for PHP 8.3.
- The **`mollie/mollie-api-php`** PHP library (`^2.52`) — this is pulled in
  automatically when you install with Composer (see below).
- Core's **Datetime** and **Options** modules, which Drupal enables automatically
  as dependencies.
- A **Mollie account**. You cannot take payments without one — sign up at
  [mollie.com](https://www.mollie.com/) and grab your API keys from the Mollie
  dashboard.
- For the Webform submodule only: the contributed **Webform** module
  (`webform/webform`).

## Install with Composer

From the project root:

```bash
composer require drupal/mollie -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`mollie/mollie-api-php` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mollie -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en mollie -y
```

## Submodules — enable the context you need

The base `mollie` module gives you the API client and the settings page, but you
also need one of the context submodules to actually collect money:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Mollie for Drupal Commerce** | `mollie_commerce` | Adds Mollie as a Drupal Commerce payment gateway. Choose this if you run a full Commerce store. |
| **Mollie for Drupal Webform** | `mollie_webform` | Takes a payment as part of a webform submission — donations, event fees, registrations — without adopting the whole Commerce stack. Requires the Webform module. |
| **Customers API** | `mollie_customers` | Manages Mollie customer records for recurring or stored-payment scenarios. |

For example, to take payments through webforms:

```bash
drush en mollie_webform -y
```

## Verify it worked

Log in as an administrator and visit **`/admin/mollie`**. You should see the
Mollie configuration form where you enter your API key. Head to
[Configuration](../configuration/index.md) to finish setup.
