# GDPR Compliance — manual setup guide

**GDPR Compliance** (`gdpr_compliance`) gives a Drupal site a few practical
building blocks that are commonly associated with the EU's General Data
Protection Regulation. It provides three things: a site‑wide **cookie‑consent
pop‑up**, a required **"I have read and agree to the Cookie & Privacy Policy"
checkbox** that you can add to key forms, and a ready‑made, multilingual
**privacy‑policy page**.

It's important to be honest about what this module is. It does **not** make your
site "GDPR compliant" on its own, and it isn't a full consent‑management platform.
Compliance is a legal and organizational matter — this module simply gives you a
lightweight, low‑dependency starting point for capturing consent and presenting a
policy, which you still need to configure, adapt, and back with real practices and
legal advice.

The three parts work like this. The **cookie pop‑up** appears at the top or
bottom of non‑admin pages; its text, buttons, colors, position, and whether it
shows to guests, logged‑in users, or both are all configurable, and once a
visitor dismisses it a cookie remembers that choice. The **consent checkbox** can
be switched on for the user registration and login forms, contact forms, node
forms, and webforms, each per bundle. The **policy page** lives at
`/gdpr-compliance/policy`, ships with English, Russian, and German text chosen by
the visitor's interface language, and can be pointed at your own policy instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it depends on the JS Cookie module).
2. [Configuration](configuration/index.md) — the two settings forms (Form
   Settings and Pop‑up Settings) and the bundled policy page.

## Where it lives in the admin menu

The module adds a **GDPR** section under Configuration, split across two forms,
both behind the **Administer GDPR compliance** permission (a restricted
permission):

- **GDPR Form Settings** — `/admin/config/gdpr/compliance` — controls the consent
  checkbox on forms.
- **GDPR Pop‑up Settings** — `/admin/config/gdpr/compliance/popup` — controls the
  cookie banner.

## How to use it

1. Enable the module and its JS Cookie dependency.
2. Open **GDPR Pop‑up Settings** to turn on and style the cookie banner.
3. Open **GDPR Form Settings** to add the consent checkbox to the forms you want.
4. Review the policy page at `/gdpr-compliance/policy`, and either edit its
   wording or point the links at your own policy.
