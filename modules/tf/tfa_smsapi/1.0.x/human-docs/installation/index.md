# Installation

## Requirements

TFA - SMS API needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **TFA (Two-Factor Authentication)** module (`tfa:tfa`), version **1.5 or
  newer** — the framework that validates the codes.
- The **SMS API** module (`smsapi:smsapi`) — the service used to actually send the
  text messages, and where you configure your SMS credentials.

There are no third-party PHP or library requirements. Your SMS API account
credentials are set up in the SMS API module; keep them in a secure, env-backed
store rather than in committed configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/tfa_smsapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including TFA and SMS API if they are not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tfa_smsapi -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tfa_smsapi -y
```

Drupal will enable the required dependencies (TFA and SMS API) at the same time.

## Set SMS as a validation method

1. Make sure the **SMS API** module is configured with your account credentials and
   at least one sender.
2. In the **TFA** settings, select the SMS API plugin as a validation method.
3. Choose the sender to use and the allowed number of code-entry attempts before an
   account is locked.

## Verify it worked

Enrol a test user with a telephone number and log in as them — they should receive
the one-time code by SMS and be able to complete the login. Confirm your SMS API
account can actually send messages before relying on this in production.
