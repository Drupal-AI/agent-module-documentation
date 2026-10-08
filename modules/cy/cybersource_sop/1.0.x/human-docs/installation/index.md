# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce**, specifically the `commerce_payment`, `commerce_order`,
  `commerce_price`, `commerce_log`, `commerce_cart`, and `commerce_checkout`
  sub‑modules.
- A **Cybersource Secure Acceptance Silent Order POST** profile
  (`profile_id` / `access_key` / `secret_key`) for each environment and currency
  you take payments in.
- Drupal's **private filesystem** configured.
- **No third‑party PHP libraries** are required — request signing uses PHP's
  built‑in `hash_hmac()`.

## Install with Composer

From the project root:

```bash
composer require drupal/cybersource_sop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cybersource_sop -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cybersource_sop -y
```

## Set up the private filesystem

The gateway reads its credentials from a private `.yml` file, so configure
Drupal's private file system: in `settings.php` set
`$settings['file_private_path']` to a directory **outside the web root**.

## A hardening recommendation

Because Silent Order POST renders card fields on **your** checkout page, the
module's maintainer recommends serving a strict Content‑Security‑Policy on
checkout pages and locking down who can inject markup there. A security‑header
module such as [Security Kit (SecKit)](https://www.drupal.org/project/seckit) can
help you set that up. It is a recommendation, not a requirement.

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can add a gateway of
type **Cybersource (Secure Acceptance SOP)**. It will warn that credentials are
missing until you place the `.yml` file — continue to
[Configuration](../configuration/index.md).
