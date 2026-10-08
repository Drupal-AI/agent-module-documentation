# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No hard module dependencies and no third-party PHP libraries declared.
- An account and credentials with a **Mobile ID service provider** (for example a
  telecom Mobile ID service) — you'll need these to complete configuration.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mobileid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mobileid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Note:** This is an early (beta) release marked *not covered* by Drupal's
> security advisory policy — test it thoroughly before relying on it in production.

## Enable the module

```bash
drush en mobileid -y
```

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to connect your
Mobile ID provider. Then test an authentication: enter a mobile number and confirm
the login prompt arrives on the phone and completes the sign-in.
