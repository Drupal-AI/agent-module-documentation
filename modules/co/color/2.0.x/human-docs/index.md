# Color — manual setup guide

**Color** (`color`) gives site administrators a point‑and‑click way to change a
theme's color scheme — its links, backgrounds, text and other elements — without
editing any CSS. It's the former Drupal core module, now maintained as a contrib
project. On a theme that supports it, the theme settings page gains a **Color
scheme** section with a farbtastic color‑wheel picker, a set of predefined color
schemes, a hex field for each recolorable element, and a live HTML preview so you
can see changes before you save.

When you save, Color doesn't just store values — it writes recolored copies of
the theme's stylesheets into your public files directory, and, if the theme ships
a base image, it uses PHP's GD library to render recolored images and a recolored
logo. Drupal then serves those generated files in place of the theme's originals,
so your new palette takes effect immediately across the site. The chosen palette
and the generated file paths are stored in a `color.theme.<theme>` config object
that exports and deploys like any other configuration.

The module works the moment you enable it — there's nothing you *must* configure
globally, and it has no settings page of its own. It only affects themes that
**opt in** to color support (by shipping a `color/color.inc` file describing
their palette). Incompatible themes simply show no color picker. It has no
dependencies on other modules, but it does require the **PHP GD library with PNG
support** to render themed images; Drupal's status report warns you if that's
missing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — recoloring a compatible theme from
   the Appearance UI, field by field.

## Where it lives in the admin menu

Color has no configuration route of its own (`configure` is null). Instead it
injects its **Color scheme** section into each compatible theme's own settings
form. Go to **Appearance** (`/admin/appearance`), then click **Settings** next to
the theme you want to recolor (or open **Appearance → Settings → *(theme)***,
`/admin/appearance/settings/{theme}`). If that theme supports Color, you'll see
the color picker there. See [Configuration](configuration/index.md) for a walk
through the form.
