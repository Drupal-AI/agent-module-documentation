# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The **Webform** module (`webform:webform`) — a hard dependency, required even if
  you only use the built‑in form.
- Core's **Media** (`media`), **Image** (`image`), **Responsive Image**
  (`responsive_image`), and **Token** (`token`) modules — used for the block's
  image and text personalisation. Drupal enables these as dependencies when you
  turn on the module.

There are no third‑party PHP library requirements. Webform is a contributed
module, so install it with Composer if it isn't already present.

## Install with Composer

From the project root:

```bash
composer require drupal/newsletter_signup_block -W
```

This pulls in Newsletter Signup Block and, thanks to `-W`
(`--with-all-dependencies`), the Webform module and any shared dependencies it
needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/newsletter_signup_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en newsletter_signup_block -y
```

Drupal will enable Webform, Media, Image, Responsive Image, and Token
automatically if they aren't on already.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. In the block browser you should now see **Newsletter
signup form** and **Newsletter signup (Webform)** among the available blocks.
Place one and continue with "How to use it" in the [overview](../index.md).
