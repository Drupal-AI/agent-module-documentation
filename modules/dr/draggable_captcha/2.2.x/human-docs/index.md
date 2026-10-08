# Draggable CAPTCHA — manual setup guide

**Draggable CAPTCHA** (`draggable_captcha`) adds a drag‑and‑drop (and,
per the project, clickable) challenge type to the **CAPTCHA** module. Instead of
reading distorted characters, the visitor moves an element onto a target to prove
they're human. It's a "challenge type" plugin: it plugs into CAPTCHA and is
selected wherever you'd normally choose a CAPTCHA style, so all of its setup
happens on CAPTCHA's own settings pages. It depends on the **CAPTCHA** module and
on **`jquery_ui_droppable`**.

Before you deploy it, weigh accessibility carefully. A drag interaction is one of
the least accessible input patterns on the web: it needs a pointing device, fine
motor control, and sustained coordination, which can exclude keyboard‑only users,
screen‑reader users, anyone with a tremor or limited dexterity, and many people
using a phone one‑handed. Because a CAPTCHA stands between a person and something
they came to do, an inaccessible one doesn't merely annoy — it can stop them
completely. The module describes itself as "draggable **& clickable**", which
suggests a non‑drag path may exist; if you use this module, confirm that path is
reachable by keyboard, announced to assistive technology, and equally effective.

Two more things worth knowing: `jquery_ui_droppable` builds on jQuery UI, which
was removed from Drupal core and is now maintained on a best‑effort basis — so
this sits on a library the project has moved away from. And this is a **beta**
release (2.2.0‑beta4). For a friendlier, more accessible alternative that
challenges invisibly and asks nothing of most visitors, consider a service like
Cloudflare Turnstile.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module along with its CAPTCHA and jQuery UI dependencies.

There is **no separate configuration page** for this module — it has no settings
form of its own. You choose it as a challenge type from the CAPTCHA module's
settings, described in "How to use it" below.

## Where it lives in the admin menu

Draggable CAPTCHA adds no admin page of its own. You configure it entirely from
the CAPTCHA module at **Configuration → People → CAPTCHA module settings**
(`/admin/config/people/captcha`), where "Draggable CAPTCHA" appears as an
available challenge type.

## How to use it

1. Install and enable this module together with **CAPTCHA** and
   **`jquery_ui_droppable`** (see [Installation](installation/index.md)).
2. Go to **Configuration → People → CAPTCHA module settings**
   (`/admin/config/people/captcha`).
3. On the **Form settings** tab, add the form you want to protect (for example a
   comment, registration, contact, or password‑reset form) and choose **Draggable
   CAPTCHA** as its challenge type. You can also set it as the default challenge
   for all forms.
4. Save, then load the protected form as an anonymous visitor to confirm the
   drag‑and‑drop challenge appears — and test the clickable/keyboard path before
   relying on it.
