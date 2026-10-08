# Orejime — manual setup guide

**Orejime** (`orejime`) is the Drupal integration of the accessible Orejime
cookie-consent JavaScript library (a fork of Klaro, built to meet the French
RGAA accessibility standard as well as WCAG). It shows visitors a GDPR-style
consent banner and modal, lets them accept or reject specific categories of
third-party cookies and scripts, and — crucially — holds tracking scripts and
embedded iframes back until the visitor has actively opted in.

You describe each thing that needs consent as a **consent service** — a small
content entity with a label, a description, the purposes it serves, and the list
of cookies it sets. Orejime renders those services in the consent modal. Google
Analytics and Google Tag Manager are recognised and gated automatically; any
other registered JavaScript file can be gated by matching its filename to a
service; and authors can hand-tag inline scripts or embeds so they only load
after consent. When a visitor withdraws consent, Orejime deletes the cookies the
service declared.

Global banner behaviour — the cookie name and lifetime, the privacy-policy link,
whether the modal must be answered before the site can be used, an optional
colour palette, and where the Orejime library files are loaded from — lives in a
single settings form. By default the banner is suppressed on admin pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and check its dependencies.
2. [Configuration](configuration/index.md) — the global banner settings form,
   the consent-service entities, and how scripts get gated, field by field.

## Where it lives in the admin menu

Once enabled, Orejime adds two things to the admin UI:

- **Consent services** are managed as content at
  **Content → Orejime services** (`/admin/content/orejime_service`).
- **Global banner settings** live on the module's own settings form (config form
  route `orejime_service.settings`).

Full administrative control is gated by the **Administer orejime entities**
permission — grant it only to trusted administrators, because the consent text
they author is rendered in the banner for every visitor.
