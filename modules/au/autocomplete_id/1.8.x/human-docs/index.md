# Autocomplete Entity ID — manual setup guide

**Autocomplete Entity ID** (`autocomplete_id`) extends Drupal's standard entity
autocomplete so editors can find and pick a referenced entity by typing its
numeric **entity ID**, not just its label. When what an editor types matches an
existing entity's ID, an extra suggestion — shown as `Label (id)` — is prepended
to the top of the results list, alongside the usual label-based matches.

The problem it solves shows up in a few everyday situations: two nodes share the
same title and you need the *exact* one; a power user is working from a spreadsheet
of IDs; or someone knows an entity's ID but not its precise title. Rather than
maintaining a custom "reference by ID" hack, this module adds the capability in a
maintained, core-compatible way, while preserving all of core's normal label
matching.

You can turn it on in three ways. The most targeted is the **Autocomplete ID field
widget**, which you select on an entity reference field's *Manage form display*.
There's also a reusable `entity_id_autocomplete` **form element** for custom forms.
And there's a **global toggle** on the settings page that enables ID matching for
*every* core entity-autocomplete field across the site at once. ID-based results
are also gated by a dedicated permission, so you can restrict them to specific
roles, and per-entity view access is always respected — users can't reference
entities they aren't allowed to see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the global toggle, permissions, and
   the per-field widget.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Autocomplete ID**
(`/admin/config/content/autocomplete-id`), gated by the **administer entity
autocomplete id** permission. The per-field widget is chosen at **Structure →
*(entity type)* → Manage form display**, and permissions are set at **People →
Permissions**.

## How to use it

Decide between the two mutually exclusive modes. For a single field, leave the
global toggle **off** and, on that field's **Manage form display**, switch its
widget to **Autocomplete match ID**. For the whole site at once, turn the global
toggle **on** to add ID matching to every core entity-autocomplete field. Either
way, an editor can type an ID like `123` and get `Article title (123)` at the top
of the suggestions. Make sure the roles that should see ID results have the **view
entity autocomplete id results** permission.
