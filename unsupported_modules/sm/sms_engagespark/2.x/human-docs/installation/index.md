# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **SMS Framework** module (`smsframework`, dependency `smsframework:sms`) —
  engageSPARK is a gateway plugin for it, so the framework must be present.
- The **`giggsey/libphonenumber-for-php`** PHP library, used for phone‑number
  handling. Composer installs it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/sms_engagespark -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in SMS Framework and
the libphonenumber library along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sms_engagespark -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms_engagespark -y
```

This enables the SMS Framework (`sms`) too if it isn't already on.

## Next step

engageSPARK has no settings form of its own. Configure it by adding an
engageSPARK gateway under **Configuration → SMS & messaging → Gateways**
(`/admin/config/smsframework/gateways`) and entering your API token and sender
settings — see the [main guide](../index.md) for the steps, and read its security
note about TLS verification before using a live account.
