# Webform Composite Tools — manual setup guide

**Webform Composite Tools** (`webform_composite`) lets site builders define
reusable custom **composite** webform elements through an admin UI, instead of
writing PHP. A composite is a single element that bundles several sub‑fields — for
example a "customer contact" block made of name + email + phone, or a standardized
address block. Core Webform supports composites, but normally building a new
reusable one means shipping a custom module with a plugin in code. This module
removes that barrier: you build the composite in the UI and it stores the
definition in configuration.

Under the hood each composite is a `webform_composite` **config entity** whose
sub‑elements are stored as YAML. Every saved composite is then exposed to Webform
as its own placeable element (a derivative of a single `webform_composite`
element plugin), so it shows up in the Webform element browser and can be dropped
onto any form, made multi‑value to collect a repeating list, and themed. Update a
composite once and every webform that uses it reflects the change. Because the
definitions live in configuration, they are version‑controllable and exportable
for deployment across environments.

You manage composites from one admin list under Webform's configuration. Each has
a human‑readable label, a machine name, and a description. You can build the
sub‑elements visually with Webform's composite builder UI, or edit the raw YAML
directly on a Source form. Everything is gated by the core **Administer webform**
permission. The module depends only on the **Webform** module, needs no extra
Composer or PHP dependencies, and has no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Webform dependency) and enable the module.
2. [Configuration](configuration/index.md) — create and manage reusable composites
   and place them on a form.

## Where it lives in the admin menu

Once enabled, composites are managed under **Structure → Webforms →
Configuration → Composites** (`/admin/structure/webform/config/composite`).

## How to use it

Create a composite in the Composites list, define its sub‑fields, and save. The
composite then appears in the Webform element browser, ready to add to any form
just like a built‑in element. See [Configuration](configuration/index.md) for the
full walkthrough.
