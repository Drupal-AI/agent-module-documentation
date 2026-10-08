# Fluid UI - Infusion — manual setup guide

**Fluid UI - Infusion** (`fluidui`) brings the **Fluid Infusion** accessibility
framework to Drupal's front end. Instead of a fixed row of "high contrast" and "big
text" buttons, Infusion offers a **preferences panel**: visitors adjust the page's font
size, line height, font style, contrast, and link styling to suit themselves, and their
choices are remembered (via cookies) as they browse. The module integrates the library
on the site's non‑admin pages.

Infusion comes from the Inclusive Design Research Centre, and that research grounding is
the reason to prefer it over an ad‑hoc accessibility overlay — it is built around the
idea that a visitor's presentation preferences are personal and portable, not a handful
of preset modes. On a public‑sector or education site with a personalisation
requirement, that is a meaningful distinction.

Two honest caveats are worth stating up front. First, a preferences layer **helps
visitors adjust presentation but does not substitute for accessible markup** — semantic
HTML, keyboard operability, focus management, and adequate contrast in the design
itself are what actually get measured against WCAG. Second, some themes need a little
extra CSS for font‑size or line‑height changes to take effect (Bootstrap‑based themes,
for example), and contrast settings do not affect elements that use CSS gradients.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Fluid
   Infusion library, and enable the module.
2. [Configuration](configuration/index.md) — the settings form that controls the
   preferences panel.

## Where it lives in the admin menu

The module's settings form is at **`/admin/config/fluidui/adminsettings`** (route
`fluidui.admin_settings_form`). Note that this page is gated by the **Access
administration pages** permission rather than the stricter *Administer site
configuration* — see [Configuration](configuration/index.md) for why that is worth a
second look.
