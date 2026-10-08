# DSFR for Drupal - Colors — manual setup guide

**DSFR for Drupal - Colors** (`dsfr4drupal_colors`) provides **color‑selection
field types** based on the official palette of the DSFR — the *Système de Design
de l'État*, the French State Design System. Instead of letting editors pick any
hex value, it constrains color choices to the on‑brand DSFR palette, so content
stays compliant with the government design system.

The module is built for real editorial control. For each field instance you can:

- **Limit the selectable colors** to a subset of the DSFR palette;
- choose the **color code integration method** (how the chosen color is emitted);
- **wrap** the selected colors into custom CSS; and
- enable **contrast‑ratio validation** against a color (a hex code or a DSFR
  color name) or against another DSFR color field.

A nice touch: it stores the **official DSFR color variable names** rather than
raw hex codes, so your content works correctly in both light and dark modes. The
palette itself is not bundled in the module — it is imported automatically from
the official DSFR sources via a cron job, so there is nothing extra to do when
you upgrade the DSFR library.

This module is part of the **DSFR for Drupal** suite. It is strongly recommended
to use it alongside the base **DSFR for Drupal** theme. (It was inspired by the
[Color Field](https://www.drupal.org/project/color_field) module, which you would
reach for instead if you needed a broader, unconstrained palette.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the module settings and, mainly,
   the per‑field color settings.

## Where it lives in the admin menu

The module has a settings form (route `dsfr4drupal_colors.settings`), reachable
from the module's **Configure** link on the **Extend** page (`/admin/modules`).
The bulk of the real configuration, however, is done **per field instance** on
your content type's **Manage fields** — see
[Configuration](configuration/index.md).
