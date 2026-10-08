# Installation

## Requirements

Tarte au citron Recaptcha is a glue module, so it needs both of the modules it
connects:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Tarte au citron** (`tarte_au_citron`) — the cookie‑consent manager.
- **reCAPTCHA** (`recaptcha`) — Drupal's Google reCAPTCHA integration.

Drupal will pull both companion modules in as dependencies, but you install
their Composer packages alongside this one so the code is present. There are no
extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/tarte_au_citron_recaptcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in `drupal/tarte_au_citron` and
`drupal/recaptcha` if they are not already required.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tarte_au_citron_recaptcha -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tarte_au_citron_recaptcha -y
```

Enabling it will also enable `tarte_au_citron` and `recaptcha` if they are not
already on.

## Verify it worked

After enabling, set up reCAPTCHA (site and secret keys) and Tarte au citron as
you normally would. Then visit a page with a reCAPTCHA‑protected form as an
anonymous visitor: the reCAPTCHA widget should stay blocked behind the Tarte au
citron consent banner until you accept it, and load only afterwards.
