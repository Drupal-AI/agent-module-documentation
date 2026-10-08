# Image Styles Builder — manual setup guide

**Image Styles Builder** (`image_styles_builder`) lets a developer create image
styles *in bulk* by declaring them in a YAML definition file inside a custom
module — no clicking through the UI. It's aimed at teams where the front‑end
hands the back‑end a list of required image styles: you write them down once, in
version control, and generate (or flush) them all with a Drush command whenever
you like.

Reach for it when you need to generate many styles quickly, when you receive a
list of styles from a colleague, when you want to regenerate the whole set
consistently across environments, or when you want to fetch a defined collection
of styles from Twig. The definitions live in a
`*.image_styles_builder_derivatives.yml` file, where each style lists its chain
of effects (scale, crop, convert to WebP, and so on).

The module ships two Drush commands: **`drush isb:gen`** discovers all derivative
definition files and creates the styles (skipping ones that already exist), and
**`drush isb:flush`** deletes the styles that a previous `isb:gen` created — a
clean rollback. It also provides an `isb_image_styles()` Twig function to fetch a
defined collection of styles in templates.

The Drupal 9/10/11 version has **no dependencies** beyond core's Image module and
requires PHP 7.4+ (8.1+ recommended).

> **Install note:** The project recommends installing it as a **dev dependency**
> (`--dev`). But if you use the `isb_image_styles()` Twig function on
> **production**, install it as a normal (root) dependency instead, so it's
> present in the production build. See [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (dev vs. root)
   and enable it.

There is **no settings form**: you declare styles in a YAML file and build them
with Drush, described in "How to use it" below.

## Where it lives in the admin menu

Image Styles Builder adds no admin page. Styles it generates appear on the core
**Image styles** screen at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). Everything else happens in code and on the
command line.

## How to use it

1. **Create a custom module** to hold your image‑style definitions.
2. **Add a derivatives file** named `yourmodule.image_styles_builder_derivatives.yml`.
   Each definition has an `id`, `label`, and `suffix`, plus a `styles` map where
   each style lists its `effects`. For example:

   ```yaml
   default:
     id: default
     label: Default
     suffix: dft
     styles:
       9_2_640x142:
         effects:
           - type: 'scale_and_crop'
             data:
               width: 640
               height: 142
       9_2_640x142_webp:
         effects:
           - type: 'scale_and_crop'
             data:
               width: 640
               height: 142
           - type: 'image_convert'
             data:
               extension: 'webp'
   ```

3. **Generate the styles:**

   ```bash
   drush isb:gen
   ```

4. **(Optional) Export** the new image‑style configuration with
   `drush config:export`.
5. **(Optional) Roll back** the generated styles with:

   ```bash
   drush isb:flush
   ```

6. **(Optional) Fetch styles in Twig** with the `isb_image_styles()` function:

   ```twig
   {% set styles = isb_image_styles('default') %}
   {{ styles|json_encode }}
   ```

> **Tip:** `isb:gen` skips styles that already exist, so it's safe to re‑run after
> adding new definitions; `isb:flush` only removes what `isb:gen` created.
