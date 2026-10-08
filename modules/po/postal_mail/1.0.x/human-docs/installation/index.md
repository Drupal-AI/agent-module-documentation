# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Mail System** (`mailsystem`) module — a required dependency that Composer
  installs for you with the `-W` flag below.
- A **Postal account** with **API credentials** (and, optionally, a webhook secret if you want
  delivery tracking).

## Install with Composer

From the project root:

```bash
composer require drupal/postal_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mail System and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/postal_mail -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en postal_mail -y
```

Mail System is enabled automatically as a dependency.

## Verify it worked

1. Grant the **Administer postal mail** permission to your administrator role.
2. Visit **`/admin/config/services/postal`** and enter your Postal API credentials.
3. On **`/admin/config/system/mailsystem`**, select **Postal Mail Delivery Platform** as the
   mail system (site‑wide or for a specific module).
4. Trigger a test email (for example a password reset) and confirm it is delivered through
   Postal. See the [manual setup guide](../index.md) for the full configuration walkthrough.
