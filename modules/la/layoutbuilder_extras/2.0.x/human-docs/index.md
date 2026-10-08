# Layout Builder Extras — manual setup guide

**Layout Builder Extras** (`layoutbuilder_extras`) is a collection of opt‑in
usability tweaks for Drupal core's Layout Builder. It doesn't add a new content
model or change how layouts are stored — it just smooths out the editing
experience with a handful of small enhancements that you switch on individually
from a single settings form.

The headline feature is an in‑place **layout swap**: an editor can convert an
existing section to a different layout (say, from one column to two) *without*
deleting it and re‑adding its blocks. The module carries the section's placed
components across to the new layout's regions for you. On top of that it can
merge the "Choose section" and (optional) Section Library "From library" pickers
into one off‑canvas dialog, show compact icon‑only add/configure/remove buttons,
add a visible drag handle, strip empty `<div>` wrappers from the rendered page,
redirect you back to the Layout Builder screen after saving a node, and hide
contextual links everywhere except on Layout Builder pages for the roles you
choose.

Every one of these features is **off by default**, so enabling the module changes
nothing until you visit the settings form and turn on what you want. It depends
only on core's `layout_builder` module and, importantly, it does **not** widen
who can edit a layout — its custom routes reuse the exact access check core
Layout Builder already applies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) add Section Library.
2. [Configuration](configuration/index.md) — the settings form, feature by
   feature, plus how the layout‑swap flow works.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → Content authoring →
Layout Builder Extras settings**
(`/admin/config/content/layout-builder-extras-settings`). Reaching it requires
the **Manage layoutbuilder_extras settings** permission
(`manage layoutbuilder_extras settings`).

## How to use it

1. Turn on the individual UX features you want from the settings form (see
   [Configuration](configuration/index.md)).
2. Edit any Layout Builder‑enabled entity as usual. If you enabled the icon‑only
   buttons or the change‑layout feature, you'll see the new affordances directly
   in the Layout Builder interface — for example, open a section's configure form
   and pick a different layout from the **Change layout** list to swap it in
   place.
