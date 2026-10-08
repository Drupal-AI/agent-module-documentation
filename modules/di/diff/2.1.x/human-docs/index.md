# Diff — manual setup guide

**Diff** (`diff`) adds a **Revisions** comparison UI so editors can see exactly
what changed between two revisions of content — field by field, with additions
and deletions highlighted. Drupal core tracks revisions but only lets you *view*
or *revert* them; it never shows *what* actually changed. Diff fills that gap by
rendering a side-by-side or inline comparison of any two revisions, breaking each
field down into human-readable text.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to choosing a
default comparison layout and comparing two revisions of a node. If you are
looking for terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Diff General Settings page](images/settings.png)

## Where it lives in the admin menu

The module's settings sit under **Configuration → Content authoring → Diff**
(`/admin/config/content/diff`). That page is organised into two tabs:

- **Settings** (`/admin/config/content/diff/general`) — the *Diff General
  Settings* form: choose which comparison layouts are available, order them, and
  tune how much surrounding context each change shows.
- **Fields** (`/admin/config/content/diff/fields`) — assign a comparison plugin
  to each field type and tune per-field options.

The comparison itself is not a separate admin page: it appears on each content
item's own **Revisions** tab, where editors select two revisions and compare them.

## Contents

1. [Installation](installation/index.md) — install Diff with Composer and enable
   it.
2. [Configuration](configuration/index.md) — choose the default diff layout(s)
   and options, then compare two revisions of a node.
