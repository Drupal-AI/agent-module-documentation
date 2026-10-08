# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce 3**, specifically the `commerce_payment`, `commerce_order`,
  `commerce_price`, and `commerce_log` sub‑modules.
- The official **Cybersource PHP SDK**, which Composer installs automatically as
  a dependency of this module.
- A **Cybersource account** with REST API keys. To use 3‑D Secure, Payer
  Authentication must be enabled on that account.
- Drupal's **private filesystem** configured (used to hold the credentials file —
  see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/cybersource_rest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Cybersource
PHP SDK and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cybersource_rest -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cybersource_rest -y
```

## Set up the private filesystem

The gateway reads its API credentials from a private `.yml` file, so Drupal's
private file system must be configured. In `settings.php`, set
`$settings['file_private_path']` to a directory **outside the web root** if you
have not already. This keeps the credentials unreachable over the web.

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can add a gateway of
type **Cybersource REST**. Until you place the credentials file, the gateway
reports a credentials‑missing warning — that's expected, and the next step is
[Configuration](../configuration/index.md).
