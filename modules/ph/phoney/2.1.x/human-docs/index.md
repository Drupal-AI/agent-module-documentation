# Phoney — manual setup guide

**Phoney** (`phoney`) helps hide telephone numbers from spam bots while keeping them
readable — and clickable — for real visitors. It encodes a phone number and hides it
behind a data attribute in the page markup; a small piece of JavaScript in the
visitor's browser then decodes it and rewrites it as a normal clickable phone link.
A scraper reading the raw HTML sees only the obscured value, while a person sees the
real number.

The module offers this in two forms: an **input filter** you can add to a text
format (so numbers written into content get obfuscated automatically) and, new in
the 2.1.x version, a **field formatter** for telephone and/or text fields. The
current display format is built for US ten‑digit numbers such as (234) 456‑7890.
Note there is **no non‑JavaScript fallback** — the number only becomes visible once
the browser runs the decoding script. It depends on core's Field module and targets
Drupal 11.

> **Understand its limits: this is a deterrent, not real protection.** The number is
> still delivered to the browser (that is how it gets shown), so a determined
> scraper — or anyone who views the page and reads it — can still obtain it. Phoney
> reduces *casual* automated harvesting; it does **not** keep a number private. If a
> number genuinely must not be exposed, do not publish it at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
set it up either on a text format or on a field's display, described in "How to use
it" below.

## How to use it

Choose whichever fits how your numbers reach the page:

**As a text‑format filter** (for numbers typed into content):

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format your authors use and enable Phoney's phone‑obfuscation
   filter, then save. Numbers entered in that format are now obfuscated on display.

**As a field formatter** (for telephone or text fields, Drupal 11):

1. Go to **Structure → Content types → *(your type)* → Manage display**.
2. In the **Format** column for your telephone or text field, choose Phoney's
   formatter, then **Save**.

Either way, visitors see a normal clickable phone link, while the raw markup carries
only the obscured value — keeping the limits above in mind.
