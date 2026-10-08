# Layout Builder Section Variations — manual setup guide

**Layout Builder Section Variations** (`layout_builder_section_variations`) lets you
define named **variations** of core **Layout Builder** sections, so editors can pick
a preset style or configuration when they add or edit a section — keeping section
design consistent across a site. It also generates Twig template suggestions based on
the selected variation, so themers can override the markup for each variation
without custom PHP.

You define the available variations once on a configuration page, and from then on a
new **Variation** field appears whenever an editor adds or edits a section in Layout
Builder. Choosing a variation both records that choice and adds theme hook
suggestions the theme can target. It is a site‑building / theming feature: it affects
layout configuration only, and has no content or access role beyond its own
permission. It depends on core Layout Builder and belongs to the "Utilities"
package.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define your section variations and
   understand the template suggestions they generate.

## Where it lives in the admin menu

The module adds a configuration page for defining variations at **Configuration →
Content authoring → Section variations**
(`/admin/config/content/layout-builder-section-variations`). Once variations are
defined, you use them from within the Layout Builder UI when adding or editing a
section, described in [Configuration](configuration/index.md).
