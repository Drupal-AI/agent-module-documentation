# Embedded Content — manual setup guide

**Embedded Content** (`embedded_content`) is a framework for letting editors drop
**reusable, configurable components** into CKEditor 5 content — a call-to-action
box, a chart, a pricing table, a map embed, a promo block — without ever giving
those editors the ability to write raw HTML or set CSS classes. Developers define
each component once, in code, as a plugin; editors then insert and configure it
through a toolbar button and a dialog, and see a live preview right inside the
editor.

The pieces fit together like this. A developer writes one or more **Embedded
content plugins** (the components, each with its own configuration form and render
output). A site builder creates one or more **Embedded content buttons** — each
button becomes a CKEditor 5 toolbar item with its own icon, labels, and dialog
size, and can be restricted to offer only certain plugins. You then wire a button
and the module's **text filter** into a text format. When an editor clicks the
button, picks a component, and fills in its options, the module stores a tidy
`<embedded-content>` tag; on output, the filter swaps that tag for the component's
real, themed markup.

The big advantage is governance: component markup and styling live in code, so
editors only pick and configure — they never touch the format's allowed-HTML, and
you control exactly which components each role may insert via per-button
permissions. One important note: the module **ships no concrete components of its
own** — it is a framework, so a developer must add the plugins (the bundled test
module shows working examples). It requires CKEditor 5 and a couple of Symfony
libraries.

This guide is written for a **human** setting up the feature. If you want terse,
token-cheap references for an AI coding agent — the plugin type, the button config
entity, the filter round trip, and permissions — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required libraries) and enable the module.
2. [Configuration](configuration/index.md) — create a button, wire it into a text
   format, and grant the permissions.

## Where it lives in the admin menu

Embedded Content has no single settings page. Its **buttons** are managed at
**Configuration → Content authoring → Embedded content**
(`/admin/config/content/embedded-content/button`), and you wire buttons into text
formats at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

At a high level: (1) a developer provides the component plugins in a module; (2) you
create an Embedded content button; (3) you add that button's toolbar item and the
Embedded content filter to a CKEditor 5 text format; and (4) you grant editors the
per-button permission plus access to that format. Then editors insert components
from the toolbar. Steps 2 to 4 are covered in
[Configuration](configuration/index.md).
