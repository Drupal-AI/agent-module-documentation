# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`drupal/webform`, version `^5.0 || ^6.0 || ^6.3`) —
  required. This is a contrib module, so Composer pulls it in for you.
- A Salesforce org with the **Web-to-Lead** feature set up, so you have a
  Web-to-Lead URL and your org's **OID**.

There are no third‑party Composer or PHP library requirements, and no API key or
secret to store — Web-to-Lead uses the public OID.

## Install with Composer

From the project root:

```bash
composer require drupal/sfweb2lead_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required **Webform** module if
you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sfweb2lead_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sfweb2lead_webform -y
```

This enables Webform as a dependency if it isn't already on. There is no settings
form to visit — you configure the integration by adding the handler to a webform.
See [Configuration](../configuration/index.md).

There are no submodules.
