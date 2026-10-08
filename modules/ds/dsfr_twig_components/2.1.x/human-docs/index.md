# DSFR Twig Components — manual setup guide

**DSFR Twig Components** (`dsfr_twig_components`) provides reusable **Twig
(Single‑Directory) components** that implement the UI elements of the DSFR —
*Système de Design de l'État*, the French State Design System. These components
render DSFR‑compliant markup, and they are used by **DSFR Core** and the other
DSFR modules to build the design system's interface in Drupal.

It is primarily a **building‑block module for the DSFR suite** rather than
something you configure directly: enable it (usually as a dependency of DSFR Core)
and its components become available to themes and modules that render DSFR
elements. It depends on the core **Media**, **Media Library**, and **Text**
modules, and supports Drupal 9, 10, and 11.

If you are assembling a DSFR site, you will normally get this module because
**DSFR Core** requires it. Theme and component developers can also use its Twig
components directly when composing DSFR‑compliant templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it supplies Twig components
used by the rest of the DSFR suite.

## Where it lives in the admin menu

DSFR Twig Components adds no admin settings page. It works behind the scenes,
supplying the components that DSFR Core and the other DSFR modules (and your DSFR
theme) use to render compliant markup.
