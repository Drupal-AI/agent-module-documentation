# Registration Extras — manual setup guide

**Registration Extras** (`registration_extras`) adds small quality-of-life
options to Drupal's built-in user registration flow. Rather than replacing the
registration form, it layers a couple of practical tweaks on top of it: you can
change the label on the registration **submit button** (so it reads, say,
"Create my account" or "Join us" instead of the default), and you can set a
**redirect path** that a visitor is sent to right after they finish creating an
account (a welcome page, an onboarding step, or a members' area).

It has no dependencies beyond Drupal core and works across Drupal 9, 10, and 11.
There is nothing complicated to wire up — enable it, set the two options you care
about, and the registration form behaves the way you want.

One thing worth keeping in mind: registration touches **account creation**, which
is a common abuse target. Registration Extras only changes cosmetic and
navigation behavior — it does not, and should not, weaken your registration
controls. Keep your email verification, admin approval, and anti-spam measures
(CAPTCHA, Honeypot, flood control) in place, and remember that anything a new
account can do is governed by your normal roles and permissions, not by this
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the submit-button label and the
   post-registration redirect path.

## How to use it

Once enabled, the module exposes its two options on its settings form. Set the
submit-button text and/or the redirect path to suit your site, save, and the
changes take effect on the next registration. See
[Configuration](configuration/index.md) for the field-by-field walkthrough.
