# Field Protect — manual setup guide

**Field Protect** (`field_protect`) guards individual fields on an entity edit form
so editors can't change them by accident. A protected field renders **locked**, and
the editor has to click an **"Unlock field"** button — after reading a warning
message you write — before the widget becomes editable. It's a good complement to
help text: where help text answers "what should I put here?", Field Protect makes
sure the editor pauses and confirms they understand the consequences of changing a
high-impact field (a background image, a set of tags, a body governed by a style
guide, and so on).

It's important to be precise about what this module is: it is a **UI-only,
client-side** guard against *accidental* edits. It does **not** implement any
server-side field access control (`hook_entity_field_access`), so it is **not a
permission boundary**. Anyone who could already save the field can still save it —
for example through the API, or by manipulating the form. Use it to reduce
fat-finger mistakes and reinforce editorial care; for genuine access control (who
may view or write a field), combine it with a real field-access module such as Field
Permissions.

Protection is turned on **per field widget** in a form display, and the module adds a
small admin page with a single **"Forget"** action that clears remembered unlocks
site-wide. Protection is applied only on the **edit** form — entity *creation* forms
are exempt, since there's nothing yet to protect from accidental change.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — protect a field on Manage form
   display, manage "remembered" unlocks, and use the Forget button.

## Where it lives in the admin menu

The per-field protection is set on each bundle's **Manage form display**. The
module's own admin page — offering the **Forget** action — is at **Configuration →
Content authoring → Field Protect** (`/admin/config/content/field-protect`).
