# Component Libraries: Editorial — manual setup guide

**Component Libraries: Editorial** (`cl_editorial`) is a **developer toolkit**, not
an end-user feature. It provides the shared building blocks that other modules use
to create low-code, editor-friendly interfaces around **Single Directory
Components (SDC)** — Drupal core's system for self-contained Twig components. On its
own it adds no admin screen and nothing for a site builder to click; you install it
because another module depends on it, or because you are building such a module
yourself.

The toolkit bundles three main pieces. First, a Form API element,
`cl_component_selector`, that renders a searchable radio list of components —
complete with thumbnails, status badges, and README documentation — which you can
narrow with allow/forbid lists and lifecycle-status filters. Second, a
`NoThemeComponentManager` service that lists and filters every component on the site
**regardless of which theme is active**, so admin tools see the full catalog.
Third, a schema-driven form generator that turns a component's JSON-schema props
into real form fields and adds a rich-text field per slot, so editors can fill a
component in without touching code.

It also ships a reusable filters trait, a small utility for classifying a
component's inputs as props or slots, two theme hooks with templates for the picker,
and a demo `cl_editorial:component-card` component. A companion submodule,
**sdc_tags** (Single Directory Components: Tagging), is bundled for tagging
components.

Because everything here is meant to be called from code, there is **no
configuration UI, no permissions, no Drush commands, and no routes**. It depends on
core's **Serialization** module; the props-to-form generation relies on the
`SchemaForms` and `Shaper` PHP libraries (installed via Composer), and
`league/commonmark` is an optional extra for rendering component READMEs as Markdown
inside the picker.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the exact API for the
selector element, the manager service, and the mapping-form helper — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the toolkit with Composer,
   enable it, and optionally add the sdc_tags submodule and Markdown support.

## How to use it

There is nothing to configure. After you enable the module, its API becomes
available to other modules:

- **Pick a component in a form** — add a `#type => 'cl_component_selector'` element
  to any form to give editors a searchable, thumbnail-driven component browser,
  optionally restricted by an allow-list, a forbid-list, or lifecycle status.
- **List components independent of the theme** — call the
  `NoThemeComponentManager` service to enumerate and filter all SDC components on
  the site.
- **Build an editor form from a component's schema** — the
  `cl_editorial_component_mappings_form()` helper generates form fields for a
  component's props and a rich-text field per slot.
- **Reuse the filter UI** — the `ComponentFiltersFormTrait` adds the
  allowed/forbidden/status filter sub-form to any settings form.

The bundled **sdc_tags** submodule adds a component-tagging system (with its own
config UI) on top of these pieces — enable it if you want to tag and group
components. For the exact function signatures and value shapes, see the
[`agent/`](../agent/start.md) docs.
