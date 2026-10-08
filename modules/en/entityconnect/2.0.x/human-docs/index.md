# Entity Connect — manual setup guide

**Entity Connect** (`entityconnect`) adds two small buttons to Entity Reference
field widgets: an **add** button (+) to create the referenced entity inline, and
an **edit** button (pencil) to jump straight to editing the entity currently
referenced. After the editor creates or edits that entity on its normal form, they
are returned to the original form with the new or edited entity already selected —
so they never lose their place while building content that references other
content.

Under the hood it's a safe detour, not a shortcut around access control. When an
editor presses a button, Entity Connect stashes the in-progress parent form in
their **private tempstore** (isolated per user) and redirects them to the target
entity type's real core add or edit form — `node.add`, a user create form, a
taxonomy term form, and so on. Core enforces its own create/edit permissions on
that form, so Entity Connect's buttons can never let someone create or edit
something they couldn't already reach normally. Once they save, a return flow
restores the parent form and drops the entity's id into the reference field.

It works with any Entity Reference field (using the default widgets —
autocomplete, select, checkboxes/radios), including multi-value fields. You set
default button and icon visibility globally, and each reference field can override
that default. A rich set of alter hooks lets developers exclude forms, restrict
which fields get buttons, and customise the add/edit and return flows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the global default settings, the
   per-field overrides, and the permissions.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Entity
Connect** (`/admin/config/content/entityconnect`), gated by the *administer
entityconnect* permission. Per-field overrides live on each Entity Reference
field's edit form under **Manage fields**.

## How to use it

Once enabled, the add/edit buttons appear on Entity Reference widgets according to
your default settings. Grant the button permissions to your editor roles, place
the buttons where you want them (globally on, then hidden per field, or globally
off and enabled only on chosen fields), and editors can then create or edit
referenced entities inline. See [Configuration](configuration/index.md) for the
details.
