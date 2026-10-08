# Form Style — manual setup guide

**Form Style** (`form_style`) renders a single page containing (nearly) every
common Drupal Form API element, so themers and accessibility testers can see at a
glance how forms look and behave in the active **front‑end theme**. It's a
development and theming tool — the same one that was instrumental in building
Inline Form Errors, Claro, Olivero, and the upcoming default admin theme for
Drupal 12.

The showcase page deliberately renders in the *front‑end* theme rather than the
admin theme, so you inspect exactly what real visitors see. Submitting the form
intentionally triggers a validation error on **every** element at once, which
makes it a fast way to review error states, inline error messages, focus styles,
required‑field indicators, and screen‑reader behaviour together.

**This module is not for production.** By design, the showcase route requires only
the `access content` permission, which means essentially any visitor who can view
content can reach it. That is fine for a testing tool but not for a live public
site — enable it on local development and staging only, and keep it off
production. It performs no data mutation beyond form validation, makes no external
calls, and stores nothing sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (on non‑production environments).
2. [Configuration](configuration/index.md) — the optional settings form, mainly
   the Inline Form Errors toggle.

## Where it lives in the admin menu

The showcase itself is at **`/admin/form_style`** — visit it to preview all form
elements in the current front‑end theme (a *Form Style* link also appears at the
bottom of the Navigation module's sidebar for quick access). Its settings form is
separate, at **`/admin/config/form_style`** (`form_style.settings`), gated by the
**Administer site configuration** permission. See
[Configuration](configuration/index.md).

## How to use it

1. Enable the module on a development or staging site.
2. Visit `/admin/form_style` to see the whole catalogue of form elements rendered
   in your active front‑end theme.
3. **Submit the form** — this intentionally throws a validation error on every
   element, which is the primary way to review error‑state styling and inline
   error messages.
4. Iterate on your theme's form CSS and reload to compare.
