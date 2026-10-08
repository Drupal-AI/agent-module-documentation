# Installation

## Requirements

reCAPTCHA needs **Drupal 10 or 11** and depends on two things that Composer pulls
in automatically:

- **CAPTCHA** (`captcha`, `^1.15 || ^2.0`) — the base framework that reCAPTCHA
  plugs into. You attach the reCAPTCHA challenge to forms through CAPTCHA's
  administration screens, so this module must be enabled. See the CAPTCHA module's
  own [human-docs](../../../../captcha/2.0.x/human-docs/index.md).
- **google/recaptcha** (`^1.3`) — the PHP library reCAPTCHA uses on the server to
  verify each visitor's token against Google's API. This is a Composer library, not
  a Drupal module, and needs no enabling.

You also need a **Google account** so you can register your site and obtain the
keys (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/recaptcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `captcha`
module and the `google/recaptcha` library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recaptcha -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recaptcha -y
```

This also enables the `captcha` module as a dependency. Once enabled, the
reCAPTCHA settings form appears under **Configuration → People → CAPTCHA →
reCAPTCHA** (`/admin/config/people/captcha/recaptcha`).

## Register your site with Google

Before reCAPTCHA can work you need a **site key** and a **secret key** from Google:

1. Go to Google's reCAPTCHA admin console at
   [`https://www.google.com/recaptcha/admin`](https://www.google.com/recaptcha/admin)
   and sign in.
2. Register a new site, choosing **reCAPTCHA v2** (the "I'm not a robot" checkbox,
   or invisible reCAPTCHA).
3. Add your site's domain(s).
4. Google gives you two values: a **site key** (public, shown in the browser) and a
   **secret key** (private, used only on the server). Keep the secret key safe.

You enter both of these on the reCAPTCHA settings form in the next step.

## Verify it worked

Log in as an administrator and go to `/admin/config/people/captcha/recaptcha`. You
should see the **reCAPTCHA** tab with **Site key** and **Secret key** fields:

![The reCAPTCHA settings form after installation](../images/settings.png)

If the page loads and the CAPTCHA tabs (CAPTCHA Settings, Captcha Points,
reCAPTCHA) are present, the module is installed correctly. Next, enter your keys
and wire up a form in [Configuration](../configuration/index.md).
