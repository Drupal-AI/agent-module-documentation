# Installation

## Requirements

Register with OTP needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **working mail system** — an SMTP module (such as SMTP or Symfony Mailer) or a
  correctly configured mail transport on the server. This is essential: the OTP is
  delivered **only by email**, so registration cannot complete if mail doesn't go
  out.
- Core's **Account settings** with **Visitors can register accounts** enabled, so
  the anonymous registration flow is reachable.

There are no other module, Composer, or PHP library dependencies.

> **Note:** this project is **not covered by Drupal's security advisory policy**.
> If it is your only anti-bot measure, consider pairing it with core flood
> protection or a CAPTCHA.

## Install with Composer

From the project root:

```bash
composer require drupal/register_with_otp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/register_with_otp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en register_with_otp -y
```

## Verify it worked

1. Confirm your site can send mail (send a test email through your SMTP/mail
   module).
2. Under **Configuration → People → Account settings**, confirm **Visitors can
   register accounts** is on.
3. Open `/user/register` in a logged-out browser session. You should see a **Verify
   email** button; entering an email and clicking it should deliver a 5-digit code,
   and the **Create account** button should stay disabled until you enter the
   correct code. See the parent [guide](../index.md#how-to-use-it) for the full
   flow.
