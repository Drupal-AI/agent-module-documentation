# Title Paragraph — manual setup guide

**Title Paragraph** (`drutopia_paragraph_title`) provides a reusable **title**
Paragraph type so editors can replace a page's plain default title with a richer,
hero-style title area — a title, a subtitle, an optional style/colour choice, and
an image. It's a small [Drutopia](https://www.drupal.org/project/drutopia)
feature carrying the paragraph configuration and the Twig templates that theme
it.

The paragraph is rendered through **UI Patterns** (and UI Patterns DS) for
component-based output, with dedicated templates for the title, subtitle and
style/colour fields (`paragraph--title`, `field--field-title`,
`field--field-subtitle`, `field--field-style-color`). Text formats on the title
and subtitle are constrained with the **Allowed Formats** module, and the
paragraph itself is stored via **Paragraphs** and **Entity Reference Revisions**.

Once enabled, you add the title paragraph to a content type's paragraph field and
place it at the top of the page's display to produce a consistent styled header
across your site. The module ships display configuration and templates only —
there is no custom code, no routes and no permissions of its own, so it works
with standard node and paragraph access. It depends on
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md) for the shared
image field and other common configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Paragraphs / UI Patterns dependencies.

## Where it lives in the admin menu

There is no settings form. The **title** paragraph type appears under
**Structure → Paragraphs types** (`/admin/structure/paragraphs_type`). You use it
from within any content type that has a Paragraphs field.

## How to use it

1. Make sure your content type (for example a page) has a Paragraphs field that
   allows the **title** paragraph type.
2. When editing content, add a **title** paragraph, and fill in the title,
   subtitle, style/colour and image.
3. Arrange the paragraph at the top of the content so it acts as the page header,
   and tune the paragraph's view display to theme it via the bundled UI Patterns
   templates.
