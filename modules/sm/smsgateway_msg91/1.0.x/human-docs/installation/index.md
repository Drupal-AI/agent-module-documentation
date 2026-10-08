# Installation

## Requirements

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- **PHP 8.1** or newer (`php_requirement: 8.1`).
- The **SMS Framework** module (`drupal:sms`) — MSG91 is a gateway plugin for it.
- The **Token** and **ECA** modules — the module documents these as required
  companions (Token for template placeholders, ECA for the event‑triggered send
  actions).
- An **MSG91 account** with an auth key and registered flow/template ids.

## Install with Composer

From the project root:

```bash
composer require drupal/smsgateway_msg91 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the SMS Framework
and the other dependencies along with the module. If Composer does not resolve
Token and ECA automatically, add them explicitly:

```bash
composer require drupal/smsgateway_msg91 drupal/token drupal/eca -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smsgateway_msg91 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smsgateway_msg91 -y
```

Make sure **SMS Framework** (`sms`), **Token**, and **ECA** are enabled as well.

## Next step

Enter your MSG91 auth key and flow settings — see
[Configuration](../configuration/index.md).
