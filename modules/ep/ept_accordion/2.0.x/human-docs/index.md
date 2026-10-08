# EPT Accordion — manual setup guide

**Extra Paragraph Types (EPT): Accordion** (`ept_accordion`) adds a ready-made
**Accordion / FAQ** Paragraph type to your site, so editors can build collapsible
accordion sections anywhere Paragraphs are used — an FAQ list, a "How it works"
walkthrough, product specs, or any content that reads better as expandable
panels. The interactive behaviour is powered by the jQuery UI Accordion plugin,
and editors configure it all through a settings form, no theming or code required.

It is part of the **Extra Paragraph Types (EPT)** family, which shares a common
core module (**EPT Core**) for global colors and responsive breakpoints. When you
install it, two Paragraph types are added as default configuration: `ept_accordion`
(the wrapper that holds the whole accordion) and `ept_accordion_section` (one
collapsible panel, each with a title and a rich-text body). You place the wrapper
on any Paragraphs field, add as many sections as you like, and pick the accordion
options.

The module has **no settings page and no permissions of its own** — the two
Paragraph types and their fields are the deliverable. There is one nice detail to
know: uninstalling the module intentionally leaves the Paragraph types in place, so
your existing content is not disturbed.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside its EPT
   Core, Paragraphs, and jQuery UI Accordion dependencies, then enable it.

## Where it lives in the admin menu

There is no dedicated settings page. The accordion is a **Paragraph type** you add
to a Paragraphs field on your content, so you work with it on the content edit form
and on the **Manage form display** / **Manage display** screens of whatever bundle
holds the Paragraphs field. Global look-and-feel (primary/secondary colors and
mobile/tablet/desktop breakpoints) is inherited from **EPT Core** at
**Configuration → Content authoring → EPT settings**.

## How to use it

1. Add a **Paragraphs** field to a content type (or reuse an existing one), and in
   its settings allow the **Accordion** (`ept_accordion`) type. You can also nest
   it inside another paragraph field.
2. When editing content, add an **Accordion** paragraph, then add one or more
   **section** items — each with a title and body — for the collapsible panels.
3. In the accordion's settings, choose how it looks and behaves:
   - **Styles** — a visual preset: *default*, *text only*, *plus/minus icons on
     the left*, or *plus/minus icons on the right* (each loads its matching CSS).
   - **Collapsible** — allow all panels to be closed at once (on by default).
   - **Closed** / **Opened** — start with all panels closed, or all open.
   - **Closed in tablet** / **Closed in mobile** — collapse the panels on smaller
     screens (the breakpoints come from EPT Core).
   - **Active** — the zero-based index of the panel that should start open (a
     negative number counts from the end).
   - **Disable** — render the accordion static (no expand/collapse).
   - **Height style** — the jQuery UI `heightStyle`: *content* (fit each panel),
     *fill*, or *auto*.
4. Save. The front end renders the collapsible accordion using the chosen options.

To customise the markup, override the `paragraph--ept-accordion*` Twig templates in
your theme.
