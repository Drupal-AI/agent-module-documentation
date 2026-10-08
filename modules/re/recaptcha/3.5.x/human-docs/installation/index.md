# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **CAPTCHA** module (`drupal/captcha`, `^1.15 || ^2.0`) — the
  framework this module plugs into.
- The **`google/recaptcha`** PHP library (`^1.3`), used for server-side
  verification. Composer installs it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/recaptcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the CAPTCHA module
and the `google/recaptcha` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recaptcha -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recaptcha -y
```

This enables both CAPTCHA and reCAPTCHA (CAPTCHA is turned on automatically as a
dependency).

## Get your Google keys

Before the challenge will work you need a key pair from Google:

1. Sign in at **google.com/recaptcha/admin** and register your site.
2. Choose **reCAPTCHA v2** ("I'm not a robot" checkbox).
3. Copy the generated **Site key** and **Secret key** — you'll paste them into the
   settings form next.

## Verify it worked

Visit **Configuration → People → CAPTCHA → reCAPTCHA**
(`/admin/config/people/captcha/recaptcha`). If the settings form loads, the module
is active. It won't protect anything yet, though — continue to
[Configuration](../configuration/index.md) to enter your keys and assign the
challenge to a form.

> **Note:** If you enable reCAPTCHA but leave the keys empty, CAPTCHA falls back to
> its built-in Math challenge on protected forms until you fill them in.
