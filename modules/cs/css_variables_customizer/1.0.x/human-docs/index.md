# CSS Variables Customizer — manual setup guide

**CSS Variables Customizer** (`css_variables_customizer`) lets you override a
theme's **CSS custom properties** — the design tokens like `--color-primary`,
`--spacing-md`, or `--font-heading` — straight from the admin interface, without
editing stylesheets or running a deployment. Modern themes express their design in
these variables precisely so they can be changed in one place; Drupal, out of the
box, gives you no way to change them without a code change. This module fills that
gap.

It is built for sites that only need **minor adjustments** to a base theme: a
client who wants their brand colour applied, a sub‑site that differs from its
parent only in accent colour, or a campaign that needs a different palette for a
few weeks. The usual alternatives — a sub‑theme per variation (a whole codebase
per client) or an old‑style colour module (which rewrote stylesheets and only ever
handled colour) — are heavier and less flexible. Here, because the theme already
declared which values are tokens, you simply adjust those tokens.

The module **auto‑discovers** overridable variables from your theme's CSS by
reading special comment annotations you add around them, works across the main
theme CSS and Single Directory Components (SDC), lets you **preview** changes
before saving, and supports multiple themes. If a variable is later removed from
the code, it simply stops appearing in the configuration page. It requires no other
modules and supports Drupal 10 and 11.

Three things are worth understanding before you rely on it. First, this is a
**beta** release (1.0.0‑beta3), so test it before production. Second, **only what
the theme declares as a variable is adjustable** — a theme that exposes three
tokens gives you three levers, no matter what a client asks for; the one‑time
theme setup below is what makes variables appear. Third, an overridden value is
written into the page's CSS, which is why previewing and validating matter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the one‑time theme setup (declaring
   stylesheets and annotating variables) and the overview page where you override
   values.

## Where it lives in the admin menu

Once you've prepared a theme (see [Configuration](configuration/index.md)), the
module's overview lives at **Appearance → CSS Variables Customizer**
(`/admin/appearance/css-variables-customizer`, config route
`css_variables_customizer.overview`), where you pick a theme and override its
variables.
