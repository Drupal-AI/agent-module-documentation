# Field Role Hints — manual setup guide

**Field Role Hints** (`field_role_hints`) lets you show **different field help
text to different editor roles** on the same entity edit form. A field's built‑in
description is static — every editor sees the same words. With this module you can
attach role‑specific guidance to a field so that, say, an *Author* sees one hint,
an *Editor* sees another, and an administrator sees a terser note — all on the same
field, without duplicating forms or touching field storage.

At render time the module looks at who is editing, resolves the best‑matching hint
for that person's roles (using a priority order you define, so the
highest‑priority matching role wins), and either **appends** it to the field's
existing description or **replaces** the description entirely — your choice, set
globally and overridable per field. It works with the common Drupal widget
structures (plain and formatted text, file, image, link, and datetime), including
nested and multi‑value widgets.

This is purely an editorial‑guidance feature. Hints are stored as a field's
third‑party settings and shown only as form descriptions — nothing about field
access, validation, or stored data changes.

> **A note on visibility.** Role hints are shown to editors as ordinary form help
> text and the whole set of per‑role hints is visible to anyone who can edit the
> field's configuration. Treat hint text as editor‑facing content, not a place for
> secrets — don't rely on it to hide sensitive information from any role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings form and the
   per‑field "Field role hints" section, field by field.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Field role
hints** (`/admin/config/content/field-role-hints`, route
`field_role_hints.settings`). The per‑field hints themselves are configured on
each individual field's edit form under **Structure → … → Manage fields**.
