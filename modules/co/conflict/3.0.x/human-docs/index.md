# Conflict — manual setup guide

**Conflict** (`conflict`) detects and resolves field‑level editing conflicts when
two people (or processes) save changes to the same entity at nearly the same
time. Instead of silently overwriting one person's edit — the default behavior
that quietly loses work — it auto‑merges the changes that don't overlap and asks
the editor to resolve only the fields that genuinely clash.

When an entity edit form is submitted, Conflict does a three‑way comparison,
field by field: the version the editor started from, the version currently stored
(which someone else may have changed in the meantime), and the values just
submitted. Changes that happened only on the stored side are merged in
automatically, so the editor is confronted only with the true local‑versus‑stored
conflicts. This is a big safety improvement for multi‑author newsrooms, long‑form
editorial content, and any workflow where stale edit forms left open in multiple
tabs can cause data loss.

How the remaining conflicts are presented is configurable per entity type and
bundle: they can be shown **inline** (embedded in the edit form) or in a modal
**dialog**. Field comparison itself is pluggable, so a developer can write a
custom comparator for a field type that needs special handling. The module is
built for developers and site builders — it exposes services, an event pipeline,
and an alter hook, but it has no admin settings page: its one configurable option
is set through configuration. A `conflict_paragraphs` submodule adds support for
Paragraphs.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent — including the FieldComparator plugin type, the event
pipeline, and the resolver services — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the inline vs dialog
   resolution strategy per entity type and bundle.

## Where it lives in the admin menu

Conflict has **no admin page**. Once enabled it works automatically on entity edit
forms, and its single option (the resolution strategy) is set through
configuration rather than a form — see [Configuration](configuration/index.md).

## How to use it

Enable the module and it starts protecting concurrent edits immediately, using
the default inline resolution UI. If you want a modal dialog instead, or different
behavior for specific content types, set the resolution strategy in config. For
Paragraphs, enable the `conflict_paragraphs` submodule. Developers can also detect
and resolve conflicts in code via the module's services — see the agent docs.
