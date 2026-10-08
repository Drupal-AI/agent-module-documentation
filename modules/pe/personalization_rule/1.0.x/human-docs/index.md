# Personalization Rule — manual setup guide

**Personalization Rule** (`personalization_rule`) is a **no‑code rule builder**
for personalizing what visitors see. Rather than writing custom code or reaching
for an external personalization platform, a site administrator assembles rules
visually — combining **conditions** ("if the visitor has this role", "if they came
from this referrer", "if they're on a mobile device") with **actions** ("show
this block", "hide that block", "inject this HTML"). The result is a flexible,
in‑Drupal way to vary content by who the visitor is and how they arrived.

Rules are built in a visual editor that supports **nested condition groups** with
**AND / OR / NOT** logic, inline editing, a live preview, and drag‑and‑drop‑style
management, so you can express fairly sophisticated targeting without leaving the
admin UI. Each rule is stored as a Drupal **configuration entity**, which means
your personalization logic is exportable and deployable like any other config.

The conditions you can combine include **user role**, **login status**, **path**,
**query string**, **referrer**, **device type**, **country**, **source**,
**time**, and **visited path**; the actions include **show block**, **hide
block**, **replace block**, and **inject an HTML snippet**. Typical uses are
promotional banners on specific pages, personalized content for logged‑in users,
hiding blocks from anonymous visitors, swapping blocks for mobile visitors, or
injecting campaign‑specific markup based on a referral source or query parameter.
It builds on core's **Block**, **User**, and **Path Alias** modules and is
designed to be extended with additional condition and action plugins.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it along with its core dependencies.
2. [Configuration](configuration/index.md) — build, preview, and manage
   personalization rules with the visual rule builder.

## Where it lives in the admin menu

After you enable the module, its **rule management** interface appears in the
admin menu, where you create, edit, enable, disable, and delete personalization
rules. Each rule opens into the visual builder with its **Builder**, **Actions**,
and **Settings** tabs, plus a **debug and preview** panel. See
[Configuration](configuration/index.md) for a walkthrough.
