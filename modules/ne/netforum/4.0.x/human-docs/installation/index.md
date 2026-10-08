# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- No contrib module dependencies. The module relies on the
  **WsdlToPhp/PackageGenerator** PHP library to generate its SOAP proxy classes;
  Composer resolves the library dependencies when you require the module.
- Access to a **NetForum xWeb** environment and a set of xWeb API credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/netforum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed and pull in the library the module builds on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/netforum -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en netforum -y
```

## Custom WSDL (optional)

If your association runs a customized NetForum implementation, you can generate
**custom proxy classes** from your own WSDL instead of relying on the standard
generated set. This is a developer step performed with the module's tooling; the
default proxy classes cover common xWeb operations out of the box.

## Verify it worked

Confirm the module is enabled (`drush pml | grep netforum`). Because this is an SDK,
the real test is authenticating to NetForum with your credentials — set those up in
[Configuration](../configuration/index.md), then exercise the module's service from
your integration code and confirm it can run a query against xWeb.
