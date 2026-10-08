# Layout Builder Sections Config — manual setup guide

**Layout Builder Sections Config** (`layout_builder_sections_config`) extends Layout
Builder's **Configure section** form with a handful of extra fields, so you can do a
few things core Layout Builder does not: show a section's administrative label to end
users as a real, styled heading, and attach a custom HTML `id` and CSS classes to a
section.

When you add or configure a section in Layout Builder, this module adds six fields:
**Show section title to end users** (a checkbox), a **Title wrapper** (which heading
tag to use, `h1`–`h6`), a **Title position**, a **Title color**, an HTML **ID**, and a
**Classes** box (one class per line). If you switch the title on, the section's admin
label is rendered to visitors wrapped in your chosen tag with position and colour
classes; the id and classes are applied to the section wrapper. This is handy for
building landing pages where each section needs a visible heading, a scroll-target
anchor, or a utility/background class — without a bespoke layout plugin.

The dropdown choices for wrapper, position, and colour are not fixed: they come from a
small settings page where you define each list as simple `key|Label` lines, so you can
offer editors exactly the heading levels and colour palette you want. Per-section
values are saved inside the section's own layout configuration, alongside the rest of
your Layout Builder data.

One thing to know up front: the module ships its own overrides of the core layout
templates (onecol, twocol, threecol, fourcol) plus matching CSS so the title and
classes actually render. If your theme overrides the same layout templates, you may
need to port these additions into your theme, or the extra output will not appear —
the [Configuration](configuration/index.md) page explains this.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including exactly where per-section values are stored and the
preprocess/theme mechanics — read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Layout Builder.
2. [Configuration](configuration/index.md) — the global settings page (the wrapper,
   position, and colour option lists) and the per-section fields on the Configure
   section form.

## Where it lives in the admin menu

Its global settings page sits at **Configuration → Content authoring → Layout Builder
Sections Config** (`/admin/config/content/layout-builder-sections-config`), gated by
the core **Administer site configuration** permission. The per-section fields it adds
appear inside Layout Builder itself, on the **Configure section** dialog you open when
editing a layout.
