# Layout Builder Limit — manual setup guide

**Layout Builder Limit** (`layout_builder_limit`) lets administrators put numeric
**limits on the components** editors may place in core Layout Builder sections and
regions. You can set a **minimum** and a **maximum** number of components — for
example, require at least one block in a region, or cap the number of blocks in a
whole section. Left unrestricted, Layout Builder happily lets editors add any
number of blocks, which is how pages end up inconsistent or lopsided; this module
keeps them building within guardrails.

It is a **governance / editing‑experience control**. Precisely, it constrains the
Layout Builder editing UI: it stops editors from adding more than the maximum, or
saving with fewer than the minimum, components in a section or region. Treat it as
an editorial guardrail rather than a hard security boundary — it shapes what
editors can build, not who can see content.

It pairs naturally with two sibling modules:
[Layout Builder Lock](https://www.drupal.org/project/layout_builder_lock) (lock
sections so editors cannot change them) and
[Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)
(control which component *types* may be added). Used together you can control which
sections are editable, which components may go in them, and how many components are
allowed or required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no standalone settings form**. You set the minimum and maximum
limits inside the Layout Builder UI, per section and region, as described below;
the module also adds a permission that governs who may configure those limits.

## Where it lives in the admin menu

- The component limits are set inside the Layout Builder interface, on a section's
  configuration form (for example **Structure → Content types → *(type)* → Manage
  display → Layout**).
- The module's permission is set at **People → Permissions**
  (`/admin/people/permissions`).

## How to use it

1. Grant the appropriate role the module's permission at **People → Permissions**.
2. Open a Layout Builder layout and **configure a section**. Set the minimum and/or
   maximum number of components allowed for the section, and for its regions where
   applicable.
3. Save. When editors work in that layout, Layout Builder will enforce those limits
   in the UI — preventing them from exceeding the maximum or saving below the
   minimum.

> **Note on guardrails vs. access:** these limits shape the editing experience;
> they are not access control. If a particular block must be hidden from certain
> users, protect it with the block's own access rather than relying on placement
> limits.
