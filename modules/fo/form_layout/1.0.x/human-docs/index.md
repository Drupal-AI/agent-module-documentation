# Form layout — manual setup guide

**Form layout** (`form_layout`) is a lightweight way to organise content‑entity
edit forms into **tabs or accordions**. It adds a dedicated *Manage form layout*
tab to the Manage form display interface, where you drag fields into regions and
pick how those regions are presented — vertical tabs, horizontal tabs, or
collapsible details/accordions. All your fields stay exactly as they are; they
are simply grouped so a long form is easier for editors to navigate.

It is a focused alternative to the well‑known **Field Group** module. Field Group
is mature and capable, and remains the right choice for many projects — but its
scope spans both form and display concerns and its configuration is woven into
the main Field UI. Form layout deliberately does less: it handles *edit‑form*
organisation only, keeps layout separate from widget configuration, and stores
its settings directly on the form display entity for predictable behaviour.

Because layout is configured per form display, you can define **different layouts
per form mode** — for example a trimmed layout for a Register mode versus the full
default form — and enable or disable it per display without touching global
settings. It automatically hides any tab or accordion that ends up with no
accessible fields, and it is compatible with **Paragraphs** widgets for nested,
component‑based content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it needs core's Field UI).
2. [Configuration](configuration/index.md) — choose which entity types get the
   feature, then define regions and drag fields into them per form display.

## Where it lives in the admin menu

There are two places you work with Form layout. Global setup — choosing which
entity types are eligible — is at **Configuration → Content authoring → Form
layout** (`form_layout.admin_settings`). The actual grouping is done per bundle
on its **Manage form layout** tab (for example **Structure → Content types →
Article → Manage form layout**). Both are covered in
[Configuration](configuration/index.md).
