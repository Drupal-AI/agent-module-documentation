# Patternkit — manual setup guide

**Patternkit** (`patternkit`) loads your design system's templates, patterns, and
components into Drupal as **blocks**, so you can drop them onto pages and layouts.
Point it at a pattern library — a directory of Twig templates, each paired with a
JSON Schema file of the same name — and every pattern becomes a block that appears
in the block list and in **Layout Builder**. Because they're ordinary blocks,
anything that uses blocks (Layout Builder, Page Manager, the Block layout, and so
on) can act as a custom page‑builder app driven by your component library.

The pairing is what makes it powerful. The Twig template renders the component; the
JSON Schema (Draft 4+) drives an **editor UI** so content editors fill a pattern's
fields through a form instead of hand‑editing template variables. Editors can even
drop Drupal **tokens** into pattern fields — pulling values from context such as
the current node, user, or language — rather than picking through template
variables. When a pattern block's configuration is saved, Patternkit caches the
template in the database (to guard against origin failures and to lock in the
version), and you can re‑sync a block, or the whole library, when your schema or
templates change.

Patternkit parses pattern libraries from the local filesystem or via REST
endpoints, currently supports directories of Twig templates (including
`@namespace/component` namespaces), and ships three submodules: an **example**
library to try out of the box, a **media library** integration, and **usage
tracking**.

**A security note worth reading up front:** Patternkit renders patterns with
field values supplied by editors. As with any such system, your pattern templates
must properly **escape** the values they render, or editor input could inject
markup or scripts (XSS). Restrict who can place and configure patterns to trusted
editors via the module's permission. Note also that this project does **not** carry
official security‑advisory coverage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — the library settings, how to register
   a pattern library, keeping cached patterns in sync, and the permission that
   gates who can build with patterns.

## Where it lives in the admin menu

Patternkit's settings live at the **Patternkit** admin settings page (route
`patternkit.settings`), where you manage library settings and can update the whole
library at once. Patterns themselves appear as blocks in **Structure → Block
layout** (`/admin/structure/block`) and in Layout Builder.
