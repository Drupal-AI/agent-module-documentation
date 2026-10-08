# Editing Helper — manual setup guide

**Editing Helper** (`editing_helper`) improves the editing experience for content
managers by showing **configurable, toggleable help text** right where they work —
on fields, blocks, and views. It adds a small helper button on specified content
items; when an editor clicks it, a help panel opens with guidance on how to fill in
or edit that content. The idea is to keep instructions next to the content entry
point, so editors get consistent, concise guidance without hunting through separate
documentation.

You author the help text as an administrator, so it's a trusted input surface — not
something visitors submit. There are a few places to set it:

- **Default help text** for several contexts — inline block content, reusable block
  content, and view field / node / taxonomy text — configured on the module's
  settings form.
- **Per‑field help**, added as an *Editing Helper Description* textarea on each
  field's configuration form (stored as a third‑party setting on that field, and
  taking precedence over the generic defaults).
- **Per‑view help**, attached to a view via an "Editing Helper" display extender.

Help content can be plain text or HTML for richer formatting. Because it may
contain admin‑authored HTML, treat it as the trusted‑role responsibility it is
(standard for any admin‑entered markup). Two permissions govern the module:
**"Administer editing helper permissions"** (configure the help text) and **"Access
to editing helper"** (see the help button and panel).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the default help text, add
   per‑field and per‑view help, and grant the permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Description Helper**
(`/admin/config/content/editing_helper/config`), gated by the **"Administer
editing helper permissions"** permission. See
[Configuration](configuration/index.md) for the full walkthrough.
