# Contact Default Field Override — manual setup guide

**Contact Default Field Override** (`contact_default_fields_override`) lets you
customize the **built-in fields of a core Contact form** — the standard *name*,
*email*, *subject* and *message* fields that every contact form has. Out of the
box, Drupal fixes their labels, descriptions and required settings; this module
lets you change them on a per-form basis.

The problem it solves is that core exposes those four fields to visitors but gives
you no way to relabel them, add help text, or make one optional. This module adds
those default fields to the contact form's **Manage fields** page, so you can edit
their **label**, **description**, and **required** setting just like any other
field. It depends on core's **Contact** module and on **Field UI** (the module
that provides the Manage fields interface).

It changes only how those default fields are presented — it does not touch who can
see or submit a contact form. Access is still governed entirely by core's contact
permissions, and the module adds no permissions of its own.

There's no central settings page; you configure the overrides on each contact
form's Manage fields screen, described in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (along with core Contact and Field UI).
2. [Configuration](configuration/index.md) — override the default fields on each
   contact form via Manage fields.

## Where it lives in the admin menu

There is no dedicated settings page. You work per contact form at **Structure →
Contact forms → *(your form)* → Manage fields**
(`/admin/structure/contact/manage/<form>/fields`), where the module surfaces the
default name, email, subject and message fields for editing.
