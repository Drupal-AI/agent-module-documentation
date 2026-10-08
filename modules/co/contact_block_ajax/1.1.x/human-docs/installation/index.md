# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer.**
- Core's **Block** module (`block`) and **Contact** module (`contact`) — both are
  dependencies and Drupal enables them automatically.

Optionally, it integrates with anti-spam modules (CAPTCHA, Image CAPTCHA,
reCAPTCHA, Honeypot) and the Flood Control module if you have them, but none are
required.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_block_ajax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_block_ajax -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_block_ajax -y
```

## Verify it worked

After enabling, place the **Contact Block AJAX** block in a region (see
[Configuration](../configuration/index.md)) and view a page where it appears near
the bottom. Scroll down: the contact form should load in place as it enters the
viewport, and submitting it should post without a full page reload.
