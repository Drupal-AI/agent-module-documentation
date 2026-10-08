# Contact Formatter — manual setup guide

**Contact Formatter** (`contact_formatter`) adds a field formatter that renders a
full, working Drupal contact form **inline**, right inside your content. Wherever
you have an entity‑reference field pointing at a contact form, you can choose this
formatter on the *Manage display* tab and the referenced form appears in place —
no custom template, block or code required.

The module ships a single formatter plugin, **"Rendered Contact Form"**
(`contact_field_formatter`), that applies to `entity_reference` fields whose
target is the core `contact_form` entity type. For each referenced form it builds
a fresh contact message and renders that form's submit form as the field's
output. Submissions go through core's normal contact handling — recipients,
auto‑reply, flood control — exactly as they would on the standalone contact page.

This is a site‑builder's convenience: point a field at, say, the site‑wide
"Feedback" form on one node and a "Request a quote" form on another, and let
editors choose which form appears simply by changing the referenced value.
Personal (per‑user) contact forms are deliberately skipped, because they need a
target user that a rendered‑in‑content form does not have.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Contact Formatter has **no settings page of its own** — it is a formatter you
select on a field's display. You will work with it on any bundle's **Manage
display** tab (for example **Structure → Content types → *your type* → Manage
display**).

## How to use it

Contact Formatter has no configuration; you use it by choosing it as a field's
format. The steps:

1. Make sure core's **Contact** module is enabled and you have at least one
   contact form (the default **Feedback** form works, or any custom one).
2. Add an **entity‑reference field** to a bundle (node, taxonomy term, block,
   media, paragraph, or any fieldable entity), and set its reference type to
   **Contact form**.
3. Set a value on the field — pick which contact form(s) you want to show.
4. On that bundle's **Manage display** tab, set the field's **Format** to
   **"Rendered Contact Form"** and save. There are no formatter options to set.

View the entity and the contact form renders inline. Combine it with view modes
if you want the form to appear only in, say, the full view and not the teaser.

**Note:** Personal contact forms render nothing (they need a target user), so use
the site‑wide **Feedback** form or a custom contact form.
