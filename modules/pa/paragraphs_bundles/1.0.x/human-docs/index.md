# Paragraphs Bundles — manual setup guide

**Paragraphs Bundles** (`paragraphs_bundles`) is a suite of ready‑made Paragraph
types for page building. Instead of hand‑modelling fields for every kind of
content block, you enable the bundles you want — accordion, carousel, hero,
grid, tabs, card, image, modal, and many more — and editors compose pages out of
them. Each bundle is split into a **Content** tab (the actual fields) and a
**Display** tab, where an editor sets that individual paragraph's background,
text and border colours, border, radius, margin, padding, width, box‑shadow, and
background opacity — all without writing any CSS.

The clever part is how styling works: each bundle's Twig template reads the
Display‑tab fields and emits them as CSS custom properties (e.g.
`--pb-bg:rgba(...)`) and utility classes on a wrapper element, so appearance is
data‑driven per paragraph instance. The suite is theme‑agnostic and uses no
jQuery, though it integrates most fully with the
[Solo](https://www.drupal.org/project/solo) theme. The base module ships the
shared field types (a **Color Picker** and a **BG Opacity Range**), the styling
machinery, and one starter paragraph type called `simple_bundle`.

Because it builds on Paragraphs, it has real dependencies:
[Paragraphs](https://www.drupal.org/project/paragraphs),
[Entity Reference Revisions](https://www.drupal.org/project/entity_reference_revisions),
and [Field Group](https://www.drupal.org/project/field_group), plus a number of
core modules (block, field, file, image, link, media, media_library, options,
text, views, and others). **26 submodules** each add a specific bundle — enable
only the ones you need. There is **no configuration page**: enabling the base
module and a submodule provisions the paragraph type and its fields
automatically; the rest is done through the normal field UI. It works on Drupal
9.4 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the custom field
types, the CSS‑variable rendering pattern, and how to clone a bundle to make your
own — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable the base module, and pick the bundle submodules you need.

## Where it lives in the admin menu

There is no settings page. You work with the suite through the standard
**Structure** area: manage your Paragraphs reference fields under **Structure →
Content types** (or on the suite's own **PB Content** node type / **PB Block**
block type), and manage the paragraph types themselves under **Structure →
Paragraphs types** (`/admin/structure/paragraphs_type`).

## How to use it

1. Enable the base module plus the bundle submodules you want (see
   [Installation](installation/index.md)). Each submodule provisions its
   paragraph type and fields on enable.
2. On the entity that should hold the blocks — a node type, or the suite's
   **PB Content** node type / **PB Block** custom block type — add (or reuse) a
   **Paragraphs** reference field.
3. In that field's settings, allow the bundle types you enabled.
4. Editors then add paragraphs and fill in the **Content** tab (the block's
   content) and the **Display** tab (its per‑instance colours, spacing, border,
   and opacity). Bundles can be nested inside layout/column bundles for
   structured sections.

Two bundles are worth calling out: **PB Content** (a `pb_content` node type that
can disable Solo‑theme regions for full‑width, region‑aware page building) and
**PB Block** (a `pb_block` custom block type you can place into any theme
region) — both let you build a whole page or region out of paragraph bundles.

The base module's **Color Picker** (`paragraphs_bundles_rgb`) and **BG Opacity
Range** (`paragraphs_bundles_range`) field types are reusable on your own
paragraph types or entities, and any bundle template can be overridden in your
theme — the CSS variables it emits are the styling contract. See the
[`agent/`](../agent/start.md) docs for those developer details.
