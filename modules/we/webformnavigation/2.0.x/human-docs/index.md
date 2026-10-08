# Webform Navigation — manual setup guide

**Webform Navigation** (`webformnavigation`) turns the progress bar on a
multi‑page (wizard) **Webform** into a real navigation control. Instead of the
progress bar being a static indicator, visitors can click any step to jump
**forwards or backwards** through the pages — reviewing and editing earlier
answers, or skipping ahead on a long form — without losing what they've already
entered.

It also makes validation friendlier on long forms. As a visitor moves between
pages, the module remembers each page's validation errors and re‑surfaces them
when the visitor comes back to that page. On the final submit it re‑validates
every page and lists all outstanding errors together, each grouped under its page
label, so nothing is missed. You can add your own extra message to that final
error summary, and optionally relax validation on the "Next" button so people can
move ahead freely (the final submit still validates everything).

To make cross‑page navigation reliable, when you switch it on the module
automatically keeps submissions as **drafts** (so progress survives), sets a
sensible auto‑purge window for stale drafts, and enables the clickable progress
link. It also colors the progress steps by state (active, has errors, complete)
with its own CSS.

There is **no global settings page**. You enable Webform Navigation **per
webform**, in that form's third‑party settings, and by adding one submission
handler. It builds on the **Webform** module and Webform's **Submission Log**
submodule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn it on for a webform: the
   third‑party settings and the required handler.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it on each webform, under
**Structure → Webforms → *(your form)*** — specifically its **Settings** (for the
third‑party options and the wizard progress bar) and its **Emails / Handlers** tab
(to add the Webform Navigation handler).

## How to use it

1. Make your webform a multi‑page wizard and turn on **Show wizard progress bar**.
2. In the form's **Third‑party settings**, enable **Forward navigation**.
3. Add the **Webform Navigation** handler to the form.

Full details are in [Configuration](configuration/index.md).
