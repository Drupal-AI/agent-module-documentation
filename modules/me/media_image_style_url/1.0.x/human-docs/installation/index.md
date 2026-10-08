# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Image** and **Media** modules enabled (Drupal enables them
  automatically as dependencies).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_image_style_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_image_style_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_image_style_url -y
```

## Grant the permission

The route is gated by the module's own permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it to the roles that should be allowed to
request styled media images. Grant it deliberately — the endpoint serves media
images, so only give it to roles you trust to consume it.

## Verify it worked

With the permission granted and an image style configured at **Configuration →
Media → Image styles**, request a known media item through the route in your chosen
image style and confirm you get back the styled image (the derivative is generated
on first request if it doesn't already exist).
