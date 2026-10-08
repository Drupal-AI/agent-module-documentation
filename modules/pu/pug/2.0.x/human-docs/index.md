# Pug (Password Update Guidance) — manual setup guide

**Pug** (`pug`) — short for **Password Update Guidance** (also styled "Password
Suggestions") — lets you customise the wording of the password recommendations
Drupal shows users as they type a new password. Instead of core's fixed labels
like "Weak", you can present your own text — "Poor", "Fair", "Nice", or a set of
custom formatting hints — through a simple admin interface. It's fully
configurable.

One thing to be clear about up front: **Pug does not enforce anything.** It only
changes the *guidance text* shown on the user add/edit form. If you need to
actually require certain password characteristics, that's the job of a validation
module such as Password Policy or Better Password; Pug complements those by
giving you a clean way to *communicate* the requirements to users, filling a gap
those modules don't cover well.

Pug is handy in a few situations: when your password validation is already
handled elsewhere and you just want clearer recommendations on the form; or when
you're building a decoupled front end and want to expose the password
recommendations to your middleware — Pug can serve them as a REST resource.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Setup is light and is covered in "How to use it" below — there's a core setting
you must turn on, then you edit the recommendation text through Pug's own
interface.

## Where it lives in the admin menu

Pug relies on a core prerequisite and then adds its own text configuration:

- The core **password strength indicator** must be enabled at **Configuration →
  People → Account settings** (`/admin/config/people/accounts`) — tick **Enable
  password strength indicator**.
- Pug's configurable recommendation **text** is edited through the module's own
  settings interface.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → People → Account settings**
   (`/admin/config/people/accounts`) and make sure **Enable password strength
   indicator** is checked — Pug's guidance appears alongside this indicator.
3. Open Pug's settings and edit the recommendation text/labels to match the
   wording you want users to see.
4. Go to a user **add or edit** form, type a password, and check the
   recommendations shown under the *Confirm password* field — they should reflect
   your configured text.

### Optional: expose recommendations over REST

If you run a decoupled front end, Pug ships a REST resource named **Password
Suggestions**. Enable the **REST UI** module, go to **Configuration → Web
services → REST** (`/admin/config/services/rest`), find *Password Suggestions*,
and enable it so your middleware can fetch the recommendations.
