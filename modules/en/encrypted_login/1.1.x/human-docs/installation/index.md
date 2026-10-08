# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**, with the **OpenSSL** extension.
- **HTTPS enabled** — listed as a requirement by the module; keep TLS enforced as
  usual.
- A **modern browser** with Web Crypto API support for the client-side
  encryption.
- Core's **User** module (always present).

> **Heads up:** this project is not covered by Drupal's security advisory policy.
> Keep HTTPS/TLS enforced on your site as usual when deploying it.

## Install with Composer

From the project root:

```bash
composer require drupal/encrypted_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/encrypted_login -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en encrypted_login -y
```

Enabling the module generates the RSA-2048 key pair and stores the private key in
Drupal's state system.

## Verify it worked

1. Confirm the module is enabled on the **Extend** page (`/admin/modules`).
2. Check the **Status report** (`/admin/reports/status`) to confirm the RSA key
   pair was generated without errors.
3. Load the login form over HTTPS and confirm you can still log in — the password
   is encrypted in the browser before submission and decrypted server-side.
