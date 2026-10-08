# Installation

## Requirements

TFA Email Support needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **TFA (Two-Factor Authentication)** module (`tfa:tfa`), installed *and*
  configured — this plugin extends TFA and cannot work without it.

There are no third-party PHP or library requirements.

## Install with Composer

Install the TFA module first if you don't already have it, then this plugin. From
the project root:

```bash
composer require drupal/tfa -W
composer require drupal/tfa_email_support -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tfa_email_support -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable both the base TFA module and this plugin:

```bash
drush en tfa tfa_email_support -y
```

(Or enable them from the **Extend** page in the admin UI.)

## Select Email OTP as a validation method

1. Go to **Configuration → People → TFA** (`/admin/config/people/tfa`).
2. In the **Default validation plugin** dropdown, choose **Email OTP**.
3. Save your configuration.

Two-factor authentication by email is now available for users to enrol in.

## Verify it worked

With Email OTP selected in TFA, enrol a test user (see
[Configuration](../configuration/index.md) for the enrolment flow) and log in as
them — you should be prompted for a 6-digit code that arrives by email. Make sure
your site can actually send mail before relying on this in production.
