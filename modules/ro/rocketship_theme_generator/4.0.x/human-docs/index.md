# Rocketship Theme Generator — manual setup guide

**Rocketship Theme Generator** (`rocketship_theme_generator`) is a **developer
scaffolding tool**. It contains a PHP script that generates component-based Drupal
subthemes for the **Dropsolid Rocketship** distribution and its components, based
on a chosen preset. The idea is to skip the tedious copy-paste-and-rename ritual of
starting a new Rocketship front-end and get a consistent, ready-to-build theme
structure in one command.

The themes it produces are set up for a modern front-end workflow: templates, CSS,
and JS are **component-based**; **Sass** (with globbing) compiles the CSS;
**Storybook** generates a styleguide; and there are options for font loading,
sourcemaps, favicon generation, critical CSS, a custom icon font or sprite, better
responsive tables, and overriding the Rocketship background-color palette. Full
instructions for working with a generated theme live in that theme's own README and
its built Storybook styleguide.

Two important notes before you reach for it:

- **This project is superseded** by the *Rocketship Starter theme*. It still works,
  but consider the newer starter theme for new projects.
- It is a **build-time / local-development tool**, not a runtime feature. It exposes
  no routes, permissions, services, blocks, or settings — enabling the module simply
  makes the generator script available. Because generation writes theme files to
  disk, run it locally, not as part of production request handling.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its front-end prerequisites).

This module has **no configuration page** — it is driven entirely by a command-line
script, described below.

## How to use it

Generate a theme by running the bundled PHP script and passing options:

```bash
php scripts/generate-theme.php --name='My theme' --machine-name=my_theme
```

Or, run it by full path from your Drupal root and place the result in your custom
themes directory:

```bash
php docroot/modules/contrib/rocketship_theme_generator/scripts/generate-theme.php \
  --name='Rocketship theme' \
  --machine-name='rocketship_theme' \
  --preset=starter \
  --theme-path='docroot/themes/custom'
```

The main options are:

- **`--name`** — the human name of your theme (avoid dashes and special
  characters).
- **`--machine-name`** — the theme's machine name.
- **`--theme-path`** — where the generated theme is written, relative to the script
  (defaults to the module's own `dist` folder).
- **`--preset`** *(deprecated, to be removed in a future minor)* — how much styling
  to include: `minimal` (only basic/structural CSS), `starter` (a bit more,
  including Rocketship elements), `flex` (more, following Rocketship Flex
  guidelines/presets), or `demo` (styling and presets for a demo site).
- **`--author`** and **`--description`** — metadata written into the generated
  `.info`, `composer`, and README files.

After generating, follow the generated theme's own **README** to install its
Node/Gulp toolchain and build the assets.

## Working with the generated theme

The generated theme uses **Gulp** as its build tool and needs a Node/Gulp
environment (see requirements). Build its CSS/JS, and — if you enabled it — its
Storybook styleguide, following the README that ships inside the theme.
