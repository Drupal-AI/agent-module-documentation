# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** and **User** modules (Block powers the reset-form block; User is
  always enabled). Drupal enables Block automatically as a dependency.
- **Optional — SMS delivery:** the **Key** module and the Twilio SDK, only if you
  want users to be able to receive the OTP by SMS as well as email.

## Install with Composer

From the project root:

```bash
composer require drupal/reset_password_email_otp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

To enable the optional SMS path, also require the SMS dependencies:

```bash
composer require drupal/key twilio/sdk
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reset_password_email_otp -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reset_password_email_otp -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → People → Reset Password
Email OTP** (`/admin/config/people/reset-password-email-otp`). You should see the
OTP settings form. Next, follow [Configuration](../configuration/index.md) to set
the OTP options and place the reset form block.
