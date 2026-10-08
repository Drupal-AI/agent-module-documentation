# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Node** module (`node`) — enabled by default on a standard install.
- A working outbound mail setup on the site, since the module sends notification
  and confirmation emails.
- Recommended: the **[CAPTCHA](https://www.drupal.org/project/captcha)** and
  **[reCAPTCHA](https://www.drupal.org/project/recaptcha)** modules to protect the
  public subscribe form.

## Install with Composer

From the project root:

```bash
composer require drupal/page_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_notifications -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_notifications -y
```

## Verify it worked

1. Place the subscribe block (see [Configuration](../configuration/index.md)) and
   confirm the subscribe form renders on the front end.
2. Subscribe with a test email address and confirm a confirmation email arrives.
3. Save an update to the watched node with the notify option checked, and confirm
   a notification email is delivered.

If emails do not arrive, check your site's mail configuration first — the module
relies on Drupal's normal mail delivery.
