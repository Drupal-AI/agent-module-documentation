# Installation

## Requirements

hCaptcha builds on the CAPTCHA framework:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The contributed **CAPTCHA** module (`drupal/captcha`), enabled — it provides the
  challenge framework hCaptcha plugs into. Composer pulls it in automatically.
- An **hCaptcha account** with a **site key** and **secret key** (free to create at
  <https://www.hcaptcha.com/>). You'll need these to configure the module.

There are no other third‑party Composer packages or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/hcaptcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the **CAPTCHA** module
(if needed) and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hcaptcha -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hcaptcha -y
```

This also enables **CAPTCHA** if it isn't already on. Or enable **hCaptcha** from
**Extend** (`/admin/modules`).

There are no submodules.

## Next steps

Enabling the module registers the *hCaptcha* challenge, but you still need to enter your
keys and assign the challenge to forms — and the keys are protected until then, so forms
show a Math fallback. Continue to [Configuration](../configuration/index.md), which also
covers storing the secret key safely as an environment variable.
