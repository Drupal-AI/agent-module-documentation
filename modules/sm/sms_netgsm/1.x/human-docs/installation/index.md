# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- The **SMS Framework** module (`smsframework`, dependency `smsframework:sms`) —
  Netgsm is a gateway plugin for it, so the framework must be present.
- A **Netgsm account** with API access for the credentials you'll enter on the
  gateway.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sms_netgsm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in SMS Framework
along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sms_netgsm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms_netgsm -y
```

This enables the SMS Framework (`sms`) too if it isn't already on.

## Next step

Add a Netgsm gateway under **Configuration → SMS & messaging → Gateways**
(`/admin/config/smsframework/gateways`) and enter your Netgsm credentials — see
the [main guide](../index.md). Store those credentials as secrets rather than
committing them, and keep the connection over HTTPS.
