# Autosave Form — manual setup guide

**Autosave Form** (`autosave_form`) quietly protects editors from losing work. As
someone fills in a form, the module periodically saves the form's current state in
the background — no full submit required — so if the browser crashes, the session
times out, or the editor navigates away by accident, the in‑progress edits are
kept. The next time they open the same form, they are offered the chance to restore
the autosaved draft or reject it and start fresh.

It works by decorating Drupal's core form builder, validator, and error handler,
which means it needs **no per‑form code** for standard entity forms. It applies
primarily to content entity edit forms (and, optionally, config entity forms), and
you can limit it to specific entity types and bundles — for example only long‑form
articles — as well as extend it to new‑entity create forms. A small "Saving
draft…" notification can appear on each autosave, with text and duration you
control.

Everything is driven from a single settings form at **Configuration → Content
authoring → Autosave Form**: the interval in milliseconds, whether to autosave
only when the form has actually changed, which entity types and bundles are
covered, and the notification behavior. Autosaved states are stored in a database
backend and purged automatically once the entity is saved, updated, or deleted (or
when relevant configuration changes). If someone else saves the same entity while
an editor has it open, the module can warn them about the conflict. Developers can
extend autosave coverage to custom, non‑entity forms via the module's form
interface and traits, and read or purge stored state through its storage service.
It depends only on core's **System** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

Autosave Form's settings sit at **Configuration → Content authoring → Autosave
Form** (`/admin/config/content/autosave_form`, route
`autosave_form.admin_settings`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Autosave Form** and confirm which
   entity types and bundles should be covered, and tune the interval — see
   [Configuration](configuration/index.md).
3. Open a covered content form, make some edits, wait for the autosave interval,
   then close and reopen the form — you should be prompted to restore your draft.
