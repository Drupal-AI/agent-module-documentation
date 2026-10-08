# Color Swatch — manual setup guide

**Color Swatch** (`color_swatch`) adds **color-swatch pickers to a theme's
settings**, giving site builders a visual way to choose theme colors instead of
typing hex codes. It is positioned as a more flexible alternative to Drupal core's
old Color module: rather than compiling a `color.css` file and slicing images, Color
Swatch renders the chosen colors as **inline CSS** through a Twig template, which is
far friendlier to modern CSS custom properties.

The key idea is that a theme defines its swatches and placeholder color roles in its
`.info.yml`, and Color Swatch turns those into form fields on the theme settings page
— where a site builder can pick one of the predefined swatches or craft a custom one
through the UI. The generated CSS is produced by a Twig template
(`color-swatch-css.html.twig`) that you can override in your theme, so you have full
control over how the placeholders become CSS custom properties.

A minimal theme declaration looks like this:

```yaml
color-swatch:
  placeholders:
    - primary
    - secondary
    - tertiary
  default: 'default'
  swatches:
    default:
      primary: '#FFFFFF'
      secondary: '#FFFF00'
      tertiary: '#FF0000'
```

Color Swatch is a theming/admin-UI helper with no content or access behavior of its
own, and it also offers a hook to change the active swatch programmatically if your
project needs custom logic. It supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

Configuration happens on your **theme's settings page** (there is no separate module
settings page), and the swatches themselves are declared in the theme's `.info.yml` —
described in "How to use it" below.

## How to use it

1. In your theme's `.info.yml`, declare a `color-swatch:` block with your
   **placeholders** (the color roles you will reference in CSS), the available
   **swatches** (each mapping placeholders to colors), and a **default** swatch (see
   the example above), then clear caches.
2. Go to **Appearance → Settings** for your theme (`/admin/appearance/settings`).
   Color Swatch adds fields there where you can pick one of the defined swatches or
   create a custom one.
3. The chosen colors are rendered as inline CSS on the page. To control that output,
   override `color-swatch-css.html.twig` in your theme — the default template maps
   each placeholder to CSS custom properties (hex, hue, lightness, saturation,
   contrast ratio, and rgb).
