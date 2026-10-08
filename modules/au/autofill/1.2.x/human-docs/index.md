# Autofill — manual setup guide

**Autofill** (`autofill`) copies the value of one text field into another as the
user types, on entity edit forms. Set up a "Display title" that mirrors the main
"Title", a "Sort name" that follows "Full name", or a "Meta title" seeded from the
heading — the editor sees the target fill in automatically, and can still override
it by hand at any time. It's a small convenience that removes duplicate typing on
content types with parallel fields.

You enable it per target field from **Manage form display**: tick "Enable Autofill
from another field", pick the source field, and save. A tiny JavaScript behavior
then mirrors the source into the target while the editor works. The mirroring is
deliberately unobtrusive — it stops as soon as the user types into the target field,
and it won't touch a target that already differs from the source when the form
loads, so it never overwrites an existing value or a manual edit.

The module is very lightweight: no admin settings page, no permissions, no
dependencies beyond Drupal core. It works entirely through core's field-widget
third-party settings and one JS file. A couple of limitations to keep in mind — it
handles only single-value **plain text (`string`)** fields, and the copy is
one-directional (source → target) and geared toward initial data entry.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable Autofill on a field from
   Manage form display and pick its source field.

## Where it lives in the admin menu

There is no global settings page. You configure Autofill on each target field's
widget settings under a bundle's **Manage form display** — for a content type that
is **Structure → Content types → (type) → Manage form display**. See
[Configuration](configuration/index.md).
