# Fences — manual setup guide

**Fences** (`fences`) lets you choose the HTML tags — and CSS classes — that wrap each
field, instead of Drupal's default `<div>` soup. Core wraps every rendered field in
generic `<div>`s (one around the field, one around the label, one around each item);
Fences lets you swap those for real, semantic tags like `<section>`, `<h3>`, `<ul>`,
`<address>`, or nothing at all — configured per field on Manage display.

You configure it right where you already manage field output: on a bundle's **Manage
display** screen, each field gains a collapsible **Fences** section (behind the gear
icon) with a tag choice for four wrappers — the whole field, its label, an optional
wrapper around all items, and each individual item — plus a CSS class box for each.
Choosing the special value **none** removes that wrapper entirely, so you can strip a
field down to just its value.

Because the choices are stored as third‑party settings on the field's formatter, each
field and view mode gets its own markup and everything exports cleanly as configuration.
The list of available tags comes from a small registry that other modules can extend,
and a global settings form controls whether Fences applies to all themes or only when
the field template came from core. The optional **Fences Presets** submodule adds
reusable named tag bundles (Inline, None, …) you can apply in one click. Fences changes
only markup, never data, so it is safe to add to an existing site to tidy up semantics
and accessibility.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the eight settings keys, the tag
registry, and the template override — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and optionally enable Fences Presets.
2. [Configuration](configuration/index.md) — the per‑field Fences settings, the two
   permissions, and the global settings form.

## Where it lives in the admin menu

The real work happens **per field** on **Structure → Content types → *type* → Manage
display** (and the Manage display screen of any other entity type). The small global
settings form sits at **Configuration → User interface → Fences**
(`/admin/config/user-interface/fences`), with the settings at
`…/fences/settings`.
