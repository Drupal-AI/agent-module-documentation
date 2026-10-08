# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **SMS Framework** module (`smsframework`, dependency `smsframework:sms`) —
  Fast2sms is a gateway plugin for it, so the framework must be present.
- A **Fast2SMS account** with an API key.

There are no additional PHP library requirements — the module states there are no
external dependencies beyond adding the API key.

## Install with Composer

From the project root:

```bash
composer require drupal/sms_fast2sms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in SMS Framework
along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sms_fast2sms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms_fast2sms -y
```

This enables the SMS Framework (`sms`) too if it isn't already on.

## Next step

Create a Fast2sms gateway and enter your API key — see
[Configuration](../configuration/index.md).
