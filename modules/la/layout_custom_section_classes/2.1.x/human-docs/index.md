# Layout Custom Section Classes — manual setup guide

**Layout Custom Section Classes** (`layout_custom_section_classes`) lets editors add
HTML attributes to Layout Builder **sections** — and to each **region** within a
section — right from the "Configure section" form. That means an ID, CSS classes
(free-typed or picked from a curated list), inline styles, and `data-*` attributes,
without touching a single line of Twig.

It extends Layout Builder's section-configuration form with fields for the section's
ID, classes, a checkbox list of predefined classes, inline styles, and `data-*`
attributes — plus the same set for every region inside the section. A global
settings form decides which of those attribute types editors are actually offered,
defines the predefined class list they can choose from, and controls how strictly
CSS class names are validated. At render time the module attaches your values to the
layout's markup.

Values are validated before they are saved: CSS identifiers are cleaned up, inline
styles are checked with a bundled CSS linter (`neilime/php-css-lint`), and `data-*`
names must start with `data-`. Three permissions let you separate who may change the
global settings, who may set section-level attributes, and who may set region-level
attributes. If the contrib **Token** module is installed, the free-text fields also
accept tokens, so a section's class or ID can derive from the host entity (for
example `[node:nid]`).

**One important caveat:** the layout template you use must actually print
`{{ attributes }}` (and `{{ region_attributes.REGION }}`) for your classes to appear.
Core's default one-column layout does this; a custom layout that hard-codes its
wrapper markup will silently drop the attributes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permissions.
2. [Configuration](configuration/index.md) — the global settings form (which
   attributes are allowed, the predefined class list, CSS validation) and how the
   per-section/per-region fields work.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Content authoring → Layout
builder section attributes**
(`/admin/config/content/layout-builder-section-attributes`). The per-section and
per-region attribute fields appear inside Layout Builder's own **Configure section**
dialog when you edit a layout.

## How to use it

1. Set up what editors are allowed to do on the [Configuration](configuration/index.md)
   page — turn attribute types on or off, and (optionally) define a list of friendly
   named classes editors can pick from.
2. Edit a layout with Layout Builder. Add or configure a section and open its
   **Configure section** form.
3. Fill in the ID, classes, predefined-class checkboxes, inline styles, or `data-*`
   attributes for the whole section, and/or for individual regions.
4. Save. As long as the layout template prints `{{ attributes }}` /
   `{{ region_attributes.REGION }}`, your values appear on the rendered section and
   regions.
