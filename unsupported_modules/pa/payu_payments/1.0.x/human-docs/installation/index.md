# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **OpenPayU PHP SDK** library (`payu/openpayu`) — Composer installs this for
  you as a dependency.
- A **PayU merchant account** with your POS ID, MD5 second/signature key, and
  OAuth client ID and secret.

> **Note:** this project is marked **unsupported/obsolete**. Prefer the actively
> maintained `payu_donations` module for new sites.

## Install with Composer

Installing with Composer pulls in the `payu/openpayu` library automatically:

```bash
composer require drupal/payu_payments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/payu_payments -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en payu_payments -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Block layout**
(`/admin/structure/block`). Click **Place block** and confirm **PayU Block** is in
the list. Then configure it with your PayU credentials (see
[Configuration](../configuration/index.md)) and test against PayU's sandbox before
going live.
