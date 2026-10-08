# Installation

## Requirements

CAPTCHA runs on Drupal 9.5, 10, or 11 (`core_version_requirement: ^9.5 || ^10 ||
^11`). It has **no other module dependencies** — the base module is self‑contained,
and its Math challenge works with nothing else installed. There is no PHP‑version
constraint beyond what your Drupal core requires.

## Install with Composer

From the project root:

```bash
composer require drupal/captcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update anything it needs to
while pulling in the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captcha -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha -y
```

Once enabled, the settings screen appears under **Configuration → People → CAPTCHA
module settings** (`/admin/config/people/captcha`). The module also ships with a few
CAPTCHA points already created for common user forms — see
[Protecting a form](../protecting-a-form/index.md).

## Add the Image CAPTCHA submodule (optional)

The base module only provides the **Math** challenge. If you want a distorted‑text
**image** challenge instead, enable the bundled `image_captcha` submodule:

```bash
drush en image_captcha -y
```

This registers a new **Image** challenge type that you can then pick as the default
challenge or assign to an individual CAPTCHA point (see
[Configuration](../configuration/index.md)).

## What about reCAPTCHA?

Google's reCAPTCHA ("I'm not a robot") is **not** part of this project. It is a
separate contrib module, [`recaptcha`](https://www.drupal.org/project/recaptcha),
that builds on top of this CAPTCHA API. Install it separately if you need it:

```bash
composer require drupal/recaptcha -W
drush en recaptcha -y
```

It then appears as an additional challenge type in the same settings and CAPTCHA
points screens described in this guide.

## Verify it worked

Log in as an administrator (you need the **administer CAPTCHA settings** permission)
and go to `/admin/config/people/captcha`. You should land on the **CAPTCHA settings**
page with its row of tabs (CAPTCHA Settings, CAPTCHA Examples, Captcha Points, …). If
that page loads, the module is installed correctly. Next,
[configure the defaults](../configuration/index.md).
