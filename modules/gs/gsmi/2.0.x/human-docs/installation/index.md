# Installation

## Requirements

- **Drupal 10.4, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- Core's **Image** module.
- The **Image Effects** module (`drupal/image_effects`) — this provides the
  **Text overlay** effect that does the actual drawing.
- The **Token** module (`drupal/token`).
- An **image toolkit that supports the text overlay effect** — either **GD** (the
  common default) or **ImageMagick**.
- A **font file** (for example a TTF) for the overlay text. The module's
  `README.md` explains where to download the free *Ubuntu Bold* font used in the
  examples and where to place it.

Note: this module is **not covered by Drupal's security advisory policy**. Weigh
that against your site's risk tolerance.

## Install with Composer

From the project root:

```bash
composer require drupal/gsmi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Image Effects and Token.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gsmi -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gsmi -y
```

## Verify it worked

Go to **Configuration → Media → Generate Social Media Image**
(`/admin/config/media/gsmi`). If the settings page loads — and once you have
created a text‑overlay image style and selected it there — the live preview at the
bottom of the page will render a generated image for a node of your choice. That
preview is the quickest confirmation the whole chain (toolkit, font, style,
tokens) is working.

If you ever need to clear every generated image, run:

```bash
drush gsmi:flush
```
