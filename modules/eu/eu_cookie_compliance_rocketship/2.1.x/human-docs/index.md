# Rocketship EU Cookie Compliance — manual setup guide

**Rocketship EU Cookie Compliance** (`eu_cookie_compliance_rocketship`) is a small
adapter that tailors the popular **EU Cookie Compliance** module to the expectations
of the **Rocketship** theme/distribution. On a Rocketship‑based site it wires
together the pieces you need for GDPR/ePrivacy cookie handling: EU Cookie Compliance
for the consent banner, **Cookie Content Blocker** to hold back embedded content
until consent, and **EU Cookie Compliance GTM** to gate Google Tag Manager behind
consent.

In other words, this module is the glue and Rocketship‑specific configuration that
makes those consent tools behave consistently within Rocketship — it depends on all
three and provides its own permissions. It is a privacy/compliance feature: used
correctly, it helps ensure non‑essential cookies and third‑party scripts do not
load before the visitor consents.

As with all consent tooling, the module only helps if it is configured to match your
site: the real work — defining cookie categories, choosing which content is blocked,
and confirming GTM is actually gated — happens in the underlying EU Cookie
Compliance, Cookie Content Blocker and GTM modules and should reflect your privacy
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its consent dependencies.

This module has **no settings form of its own** — it applies Rocketship‑specific
configuration and relies on the underlying modules for settings, described in "How
to use it" below.

## How to use it

This module is intended for **Rocketship‑based sites** that need EU/GDPR cookie
compliance. After enabling it (and its dependencies), do the actual consent
configuration in the underlying modules:

- **EU Cookie Compliance** — configure the consent banner, cookie categories and
  messaging to match your privacy policy.
- **Cookie Content Blocker** — choose which embedded content is blocked until
  consent.
- **EU Cookie Compliance GTM** — confirm Google Tag Manager (and the tags it fires)
  is gated behind consent.

Then verify, before publishing, that non‑essential cookies and third‑party scripts
genuinely do **not** load until a visitor has consented.
