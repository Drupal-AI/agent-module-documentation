# FZ152 — manual setup guide

**FZ152** (`fz152`) helps a Drupal site comply with Russian federal law 152‑FZ
("On Personal Data"), which requires that you obtain a visitor's consent before
processing their personal data and that you publish a privacy policy. The module
does two main things: it injects a **required "I consent to the processing of my
personal data" checkbox** into whichever forms you list (registration, contact,
webform, and so on), and it publishes a **ready‑made privacy‑policy page** — it
even ships with a complete Russian 152‑FZ policy so you don't have to write one
from scratch. The consent mechanics are useful for GDPR‑style consent gating too.

You choose exactly which forms get the checkbox by listing their form IDs, with
support for `*` wildcards (so `webform_submission_*` catches every webform),
a per‑form weight to control where the checkbox lands, and up to ten
configurable label texts so different forms can show different wording. The label
text allows HTML, which is how the default labels embed a link to the privacy
policy. You can also switch the checkbox to a plain informational note if you
want the text shown without blocking submission.

Two optional submodules extend it. **FZ152 Contact** (`fz152_contact`) wires the
consent checkbox into core Contact forms per contact form. **FZ152 Consent**
(`fz152_consent`) goes further and *logs* each consent — the client IP, the form
ID, and selected submitted values — as records you can review and bulk‑delete in
an admin View, which is handy for audit purposes.

The module ships Russian default configuration and is translatable via
Configuration Translation. All of its settings are gated behind a single
**Administer fz152** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pick the submodules you need.
2. [Configuration](configuration/index.md) — the three settings forms (general,
   forms list, privacy‑policy page) field by field.

## Where it lives in the admin menu

All of the settings sit under **Configuration → System → FZ152**
(`/admin/config/system/fz152`), which has three sub‑forms. The published
privacy‑policy page lives at its configured path (default `/privacy-policy`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On the FZ152 settings forms, turn the feature on, write your consent label(s),
   list the forms that should show the checkbox, and set up the privacy‑policy
   page (see [Configuration](configuration/index.md)).
3. Optionally enable **FZ152 Contact** and/or **FZ152 Consent** for contact‑form
   integration and consent logging.
