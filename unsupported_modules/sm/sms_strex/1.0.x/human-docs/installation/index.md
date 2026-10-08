# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **SMS Framework** module (`smsframework`, dependency `smsframework:sms`) —
  Strex is a gateway plugin for it, so the framework must be present.
- The **`target365/api-sdk`** PHP library — the module wraps this SDK to talk to
  Strex/Target365. Composer installs it as a dependency, and the module's
  install‑time requirements check warns you if it's missing.
- A **Strex agreement / account** for your Target365 key name and private key.

## Install with Composer

From the project root:

```bash
composer require drupal/sms_strex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the SMS Framework
and the `target365/api-sdk` library along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sms_strex -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms_strex -y
```

This enables the SMS Framework (`sms`) too if it isn't already on. After enabling,
check the site's status report (**Reports → Status report**) — the module's
requirements check confirms the `target365/api-sdk` library is present.

## Next step

Add a Strex gateway and enter your Target365 keys — see
[Configuration](../configuration/index.md).
