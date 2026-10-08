# Contact — manual setup guide

**Contact** (`contact`) provides Drupal's site‑wide contact forms (at `/contact`) and
per‑user personal contact forms (at `/user/{uid}/contact`, so logged‑in users can email
each other without exposing their addresses). If you've used Drupal before, this is the
familiar core Contact module — it was removed from Drupal core after version 11.3 and
continued as this contrib project. On Drupal 11.4+ you install this project; on Drupal
11.3 and earlier the identical module still ships in core. Either way the machine name,
routes, and configuration are the same, so nothing needs migrating.

You build contact forms as configuration: each **contact form** has a label, one or more
recipient email addresses, an optional auto‑reply, a confirmation message, and an
optional redirect (a "thank‑you" page). You can run several — for example separate Sales,
Support, and Press forms that route to different teams. Submissions are emailed to the
recipients but, by default, **not stored** in the database (a separate contrib module can
add storage if you need it). Built‑in flood control throttles spam, and you can add custom
fields (phone, department, order ID) to any form via Field UI — those fields travel into
the email body.

The module works once enabled and configured, but note one gotcha: **it ships no ready‑made
site‑wide form**. Out of the box only the special *personal* form exists, so `/contact`
returns a 404 until you create at least one contact form. Access is governed by three
permissions (administer forms, use the site‑wide form, use personal forms), and personal
forms additionally respect each user's own on/off preference.

This module has no dependencies beyond core and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (Drupal 11.4+) and enable
   the module.
2. [Configuration](configuration/index.md) — create contact forms, set recipients and
   auto‑replies, tune flood control and personal‑form defaults, add fields, and set
   permissions.

## Where it lives in the admin menu

Contact forms are managed at **Structure → Contact forms**
(`/admin/structure/contact`). Personal‑form and flood‑related defaults live on the
**Configuration → People → Account settings** page (`/admin/config/people/accounts`) and
in the `contact.settings` config object.

## How to use it

At a glance: enable the module, create a contact form at **Structure → Contact forms →
Add contact form** with your recipient address(es), set it as the default so `/contact`
uses it, and grant **Use the site‑wide contact form** to the roles that should see it. The
full walkthrough is in [Configuration](configuration/index.md).
