# Entity Bootstrap Accordion Tab Formatter — manual setup guide

**Entity Bootstrap Accordion Tab Formatter** (`entity_bs_accordion_tab_formatter`)
is a field formatter that displays the targets of an entity-reference field as
**Bootstrap accordions or tabs**. Instead of rendering a set of referenced
entities as a plain vertical list, it wraps them in Bootstrap markup so they appear
as collapsible accordion panels or as tabbed sections.

It works on `entity_reference` and `entity_reference_revisions` fields, which means
it is available for **Paragraphs** fields too — a natural fit for building
accordion/tab content out of referenced paragraph items. It is a fork of the
[Entity Reference Tab Formatter](https://www.drupal.org/project/entity_ref_tab_formatter)
project.

This is purely a display feature: it has no access-control role, and referenced
entities are rendered respecting their own access, so only entities a viewer may
see appear. Because it emits Bootstrap markup, your theme must supply the Bootstrap
CSS/JS for the accordions and tabs to look and behave correctly. There is no
central settings page — you configure everything on the reference field's *Manage
display*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. All setup happens on a field's
*Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from **Structure → Content types
(or Paragraph types, or any fieldable entity) → *(bundle)* → Manage display**.

## How to use it

1. Make sure your theme loads Bootstrap CSS/JS (this formatter produces Bootstrap
   accordion/tab markup and relies on the theme to style and animate it).
2. On the bundle that holds your entity-reference (or Paragraphs) field, go to
   **Manage display**.
3. For that field, choose the accordion/tab formatter as the **Format**.
4. Configure the formatter's display type. The module supports:
   - **accordion** — an accordion with the first panel open,
   - **accordion_closed** — an accordion with all panels closed,
   - **tab** — tabbed sections.
5. Save the display and view an entity that has values in the field to see the
   referenced targets rendered as accordions or tabs.
