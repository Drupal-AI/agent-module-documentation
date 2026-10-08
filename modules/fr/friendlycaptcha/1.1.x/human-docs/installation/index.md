# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- The **CAPTCHA** (`captcha`) module — Friendly Captcha is an add-on for it, pulled in
  by Composer.
- The **`friendly-challenge` JavaScript widget**, installed at
  `/libraries/friendly-challenge/widget.min.js` — it is not shipped with the module.
- A **Friendly Captcha account** (for a site key and API key) — unless you use the
  self-hosted *local* endpoint, which needs no account.

## Install with Composer

From the project root:

```bash
composer require drupal/friendlycaptcha -W
```

This also pulls in the required CAPTCHA module. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/friendlycaptcha -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Install the JavaScript widget

The `friendly-challenge` front-end widget is not bundled. Install it so that this
file exists:

```
/libraries/friendly-challenge/widget.min.js
```

You can do this by downloading it, by requiring the npm-asset package
(`composer require npm-asset/friendly-challenge`), or via NPM. If the file is
missing, a warning appears on the status report at **Reports → Status report**
(`/admin/reports/status`).

## Enable the modules

```bash
drush en captcha friendlycaptcha -y
```

## Get your keys (unless using local mode)

Register at `https://app.friendlycaptcha.com/account` to obtain a **site key** and an
**API key**. You'll enter these on the settings form. If you prefer to run entirely
self-hosted, you can skip this and choose the **local** endpoint during configuration
— no keys needed.

## Verify it worked

Go to **Configuration → People → CAPTCHA** (`/admin/config/people/captcha`). Friendly
Captcha should be available as a challenge type you can select as the default or
attach to a specific form. The next step is [Configuration](../configuration/index.md).
