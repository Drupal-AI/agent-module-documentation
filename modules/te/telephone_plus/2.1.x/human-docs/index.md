# Telephone Plus — manual setup guide

**Telephone Plus** (`telephone_plus`) is a telephone **field type** for a phone
number *plus* the things that usually surround one: an optional **title** for each
entry (for example "Office" or "Helpline"), an **extension**, and a line of
**supplementary information** (for example opening hours or "ask for the duty
officer"). You can also either set a default international dialling code or let the
user pick one. Numbers can be displayed as plain text or as a clickable `tel:`
link, with optional vCard support.

The problem it solves is that a phone number is rarely just a number, and modelling
it as one makes contact details read badly. Sites usually end up with a plain
telephone field plus a separate text field — which cannot be rendered consistently
— or free text in a body field, which cannot be linked, searched, or exported.
Keeping the parts together in one field means you configure the display once and
every number on the site looks the same. That makes it a natural fit for staff
directories, office listings, and service contact details.

There is **no central settings page** — the field type comes with its own widget
and formatters, and you configure everything on the field itself when you add it to
a content type. It depends on Drupal core's **Field** and **Telephone** modules,
and there are no submodules.

A few things worth getting right, from the module's own guidance: on mobile the
`tel:` link is the whole point (a number a visitor taps versus one they memorise and
retype), and the number placed in the link must be in a dialable form — digits and
`+`, no spaces or brackets — even when the visible text is formatted for reading. An
extension does not belong directly in the `tel:` link without pause syntax, or the
link will just dial the switchboard and stop. And remember that a phone number is
personal data when it belongs to a person: publishing direct lines in a staff
directory is a disclosure decision, which is exactly where the supplementary‑info
field helps — carry "reception will transfer you" rather than an individual's
number.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Add a field to a content type and choose the **Telephone Plus** field type. On the
field's edit form and its **Manage form display** you control which parts (title,
extension, supplementary info, dialling code) editors can fill in; on **Manage
display** you choose a formatter — **Plain text** to show the number as text, or
**Link text** to render it as a `tel:` link (with extension support and optional
vCard). All of this is configured per field; there is no site‑wide settings page.

## A note on versions

The **2.1.x** series has the same features as 2.0.x but adds support for PHP 8.4+.
The 2.x line is the current, recommended one; the older 9.0.x release is legacy and
no longer receives core‑compatibility updates.
