# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install.
- **PHP 7.4 or newer**.
- The **Stripe PHP library**, which the module declares as a dependency — so you
  must manage your site with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/stripe_pay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Stripe PHP
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/stripe_pay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **Package name.** Install `drupal/stripe_pay` (matching the machine name
> `stripe_pay`). Some older notes say `composer require "drupal/stripe"` — that is
> a different project and is not what you want here.

## Enable the module

```bash
drush en stripe_pay -y
```

## Verify it worked

Visit **`/admin/stripe-configurations`**. If the Stripe settings form loads, the
module is installed. The next steps — entering your keys and adding the payment
field — are covered in [Configuration](../configuration/index.md). Before you
take real payments, read the security caveats on that page.
