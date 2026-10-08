# Email Message field — manual setup guide

**Email Message field** (`email_message`) provides a compound **field type** that
stores an email as a single unit: an email **subject** plus a formatted email
**body**. You could achieve something similar with a separate text field and text
area, but there are times when you want to treat an email message as one whole
thing you can reference — and that is exactly what this field gives you.

Under the hood the field extends core's long‑text field, adding a required
subject alongside the formatted body (with its text format). It ships a matching
**widget** (a subject textfield plus a formatted body area) and a **formatter**
for display, and it exposes helper methods so custom code or a workflow can read
the two parts back out. A field value counts as empty unless *both* the subject
and body are set.

It is a developer/site‑builder building block: use it wherever an entity needs to
carry a ready‑to‑send email as data — notification templates, per‑node
autoresponders, configurable confirmation messages, or campaign copy consumed by
a mailer or an ECA/Rules workflow. It depends only on core's **Field** module.
Because the body is a formatted text field, the text format you choose governs
what markup editors may enter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no settings page**. You use it by adding a field of this type,
described in "How to use it" below.

## Where it lives in the admin menu

Email Message adds no admin settings page. You add it as a field on any fieldable
entity from **Structure → Content types → *(your type)* → Manage fields → Add
field**.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields →
   Add field**.
2. Choose the **Email message** field type, give it a label, and save.
3. On **Manage form display**, the field shows an email subject textfield and a
   formatted body area (the default widget). Pick a text format for the body.
4. On **Manage display**, use the default Email Message formatter to render the
   subject and body on the entity view.
5. From custom code or a workflow, read the parts back with the field's
   `getEmailSubject()` and `getEmailBody()` helpers (the latter returns the
   processed body).
