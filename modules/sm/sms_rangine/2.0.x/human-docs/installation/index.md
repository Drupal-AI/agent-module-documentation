# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **SMS Framework** module (machine name `sms`, dependency `sms`) — Rangine is
  a gateway plugin for it, so the framework must be present.
- A **Rangine panel** (web‑service or professional type) at `sms.rangine.ir`, for
  the username, password, and sender line you'll enter on the gateway.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sms_rangine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in SMS Framework
along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sms_rangine -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms_rangine -y
```

Make sure the **SMS Framework** (`sms`) module is enabled as well — enable it
first if it isn't.

## Next step

Add a Rangine gateway and enter your credentials — see
[Configuration](../configuration/index.md). Remember to set the **host** to
`https://sms.rangine.ir` so credentials aren't sent over plain HTTP.
