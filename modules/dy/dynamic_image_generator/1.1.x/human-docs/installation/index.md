# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`), **Image** (`image`), and **Media** (`media`) modules,
  plus Node, User, Views, Field, and System — all part of Drupal core. Drupal enables
  the direct dependencies automatically when you turn on the module.
- An account and **API key for the external HTML/CSS‑to‑Image API** — this external
  service is required for image generation to work.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_image_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_image_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_image_generator -y
```

## Store the image‑API key securely

Keep the external image API key out of code and configuration. On DDEV, save it as an
environment variable and restart so the container loads it:

```bash
ddev dotenv set .ddev/.env --html-css-to-image-key=<value>
ddev restart
```

Never commit `.ddev/.env`. Where the module supports it, reference the value through
a **Key** entity (install `drupal/key` if needed) rather than pasting the raw secret
into a form. All API traffic should be over HTTPS.

## Verify it worked

After enabling and entering your API credentials (see
[Configuration](../configuration/index.md)), create a simple template, assign it to
an image field on a content type, then add or edit a node — select the template and
save. The generated image should appear in the field, and the entry should show up in
the module's **Image Report**.
