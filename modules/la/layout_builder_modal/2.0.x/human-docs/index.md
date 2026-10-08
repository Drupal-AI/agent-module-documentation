# Layout Builder Modal — manual setup guide

**Layout Builder Modal** (`layout_builder_modal`) makes Layout Builder's
add‑ and configure‑block forms open in a roomy, centered modal dialog instead of
the default narrow off‑canvas tray. It is a small quality‑of‑life module with a
big impact on the editing experience: the cramped sidebar that ships with core
Layout Builder is awkward for complex blocks — rich text, media, custom blocks
with many fields — and this gives editors real space to work.

There is nothing to configure per block. Once enabled, a response subscriber
quietly retargets Layout Builder's relevant AJAX responses to a jQuery UI modal,
so the change applies globally across the site's Layout Builder UI. A single
settings form lets you tune the dialog: its width and height, whether it
auto‑resizes to its content, and whether the block form inside renders using the
admin theme or the active front‑end theme.

It requires only core's **Layout Builder** and **System** modules, adds one
permission for its settings form, and otherwise stays out of the way. It pairs
especially nicely with Layout Builder Styles, whose style selectors get a much
more comfortable dialog to appear in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: modal width,
   height, auto‑resize, and theme.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Layout Builder Modal**
(`/admin/config/user-interface/layout-builder-modal`). The behavior itself applies
automatically wherever editors use Layout Builder — there is no per‑layout or
per‑block setting.

## How to use it

There is essentially nothing to do beyond enabling it: turn the module on and,
from that point, adding or configuring any block in Layout Builder opens in a
centered modal rather than the off‑canvas tray. If the default dialog size does
not suit your content, adjust it on the [settings form](configuration/index.md).
Changing those settings requires the **Administer layout builder modal**
permission.
