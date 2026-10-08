# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **CAPTCHA** module (`captcha`), version **1.17 or 2.x** — a hard
  dependency. Composer pulls it in with the command below.
- A **running, self-hosted HeCAPTe server**. This is essential — the Drupal
  module is only the bridge. See <https://codeberg.org/TheMeerkat/HeCAPTe> for
  setup (it needs Go to build, or you can use the provided Docker image), and make
  sure the deployment includes a built `web/static/solver.wasm`, because the
  module proxies that file through Drupal.
- If you use **Webform**, HeCAPTe works with it through the standard CAPTCHA
  integration — no extra modules required.

## Install with Composer

From the project root:

```bash
composer require drupal/hecapte_captcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the CAPTCHA module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hecapte_captcha -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hecapte_captcha -y
```

This also enables the CAPTCHA module if it wasn't already on.

## Stand up and register your HeCAPTe server

Before configuring Drupal:

1. Get a **HeCAPTe server** running (see the requirements above).
2. In the HeCAPTe admin panel, **create a site**, and set its **allowed origins**
   to include your Drupal site's origin.
3. Copy the **Site Key** — you'll paste it into Drupal next.

## Verify it worked

Open **Configuration → People → CAPTCHA → HeCAPTe**
(`/admin/config/people/captcha/hecapte`). If the settings form is there, the
module is installed. Enter your server URL and site key, then protect a form —
see [Configuration](../configuration/index.md).
