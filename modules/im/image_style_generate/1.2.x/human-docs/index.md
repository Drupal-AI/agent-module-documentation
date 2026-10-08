# Image Style Generate — manual setup guide

**Image Style Generate** (`image_style_generate`) creates image styles *in bulk*
from a set of rules, instead of clicking each one into existence through the
admin form. It does this in an unusual but powerful way: it provides a **Migrate
source plugin**, so you describe the styles you want in a migration definition
(a YAML file) and let Drupal's core Migrate system generate the image‑style
configuration for you.

This pays off whenever image styles multiply. A design system with several
breakpoints, a few aspect ratios and a couple of quality settings quickly implies
dozens of near‑identical styles — slow to build by hand and easy to make
inconsistent. Because the definition lives in version control, the run is
repeatable, styles stay consistent, and — since it's a migration — rolling back
is a supported operation rather than deleting things one at a time.

The module itself has **no settings form**. You define what to generate in a
migration YAML using building blocks such as *style groups* (often an aspect
ratio shared by several styles), *base sizes*, and *size scales* (percentages
used to map sizes to device pixel densities). Two example submodules — a basic
and an advanced one — show the shape of a working definition. Once generated, the
styles are ordinary configuration entities, so they export, deploy, and can be
overridden like any others.

Image Style Generate requires core's **Image** and **Migrate** modules, and pairs
well with **Migrate Plus** and **Migrate Tools** for a UI and Drush commands to
run migrations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally the example submodules), and add the recommended
   Migrate tooling.

There is **no configuration page** for this module — it has no settings form. You
define styles in a migration YAML, outlined in "How to use it" below.

## Where it lives in the admin menu

Image Style Generate adds no admin page of its own. The image styles it produces
appear on the core **Image styles** screen at **Configuration → Media → Image
styles** (`/admin/config/media/image-styles`) once a migration has run.

## How to use it

1. **Create a custom module** (or use one of the example submodules as a starting
   point) to hold your migration definition.
2. **Set the source plugin** in the migration definition:

   ```yaml
   source:
     plugin: image_style_generate
   ```

3. **Describe the styles** under the source, using the module's building blocks —
   for example *style groups* keyed by aspect ratio, *base sizes*, and *size
   scales* for pixel densities. The example submodules
   (`image_style_generate_example` and `image_style_generate_example_advanced`)
   show complete, working definitions to copy from.
4. **Run the migration** — with **Migrate Tools** installed you can run it from
   Drush (for example `drush migrate:import <id>`), and roll it back with
   `drush migrate:rollback <id>`.
5. **Check the result** at **Configuration → Media → Image styles**. The generated
   styles are normal config entities you can export with `drush config:export`.

> **Tip:** Start from the advanced example submodule if your design system needs
> multiple aspect ratios and density scales — it demonstrates the full set of
> style groups, base sizes, and size scales.
