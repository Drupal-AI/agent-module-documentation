# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 7.2 or newer**.
- The **`google/recaptcha`** PHP library (`^1.2`), which Composer installs
  automatically as a dependency.
- A Google **reCAPTCHA v3** key pair (site key + secret key) — register one at
  <https://www.google.com/recaptcha/admin/create>. Be sure to choose **v3**, not v2.
- The **Webform** module, *only* if you want to use the Webform handler. The form
  element itself works without Webform.

## Install with Composer

From the project root:

```bash
composer require drupal/recaptcha_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will pull in the `google/recaptcha` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recaptcha_element -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recaptcha_element -y
```

## Handling your secret key

Your reCAPTCHA **secret key** is a credential — treat it like a password and keep it
out of version control. The recommended pattern for this project is to store the
value in an environment variable and override the setting per environment (for
example via `settings.php` or a config split), rather than committing it in exported
configuration. See [Configuration](../configuration/index.md) for where the keys are
entered.

## Verify it worked

Go to **Configuration → Web services → ReCaptcha Element**
(`/admin/config/services/recaptcha_element`). If the settings form loads, the module
is installed. Enter your keys next — see [Configuration](../configuration/index.md).
