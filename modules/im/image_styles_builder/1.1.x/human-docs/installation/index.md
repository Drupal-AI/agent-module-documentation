# Installation

## Requirements

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
  Use the `1.1.x` branch for Drupal 10 and 11 (the `1.0.x` branch was for
  Drupal 9).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- **PHP 7.4+**, with **PHP 8.1+** recommended (8.2 on Drupal 10.x).
- **Drush**, since styles are generated and flushed with `drush isb:gen` /
  `drush isb:flush`.

The Drupal 9/10/11 version has no other dependencies.

## Install with Composer

The project recommends installing it as a **dev dependency**, since generating
image styles is a build‑time task:

```bash
composer require --dev drupal/image_styles_builder
```

> **Important:** If you use the `isb_image_styles()` **Twig function on
> production**, install it as a normal (root) dependency instead, so the module is
> present in your production build:
>
> ```bash
> composer require drupal/image_styles_builder -W
> ```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/image_styles_builder`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_styles_builder -y
```

## Verify it worked

Create a custom module with a `*.image_styles_builder_derivatives.yml` file (see
the [manual setup guide](../index.md)), run `drush isb:gen`, and confirm the new
styles appear at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). Running `drush isb:flush` should remove
them again.
