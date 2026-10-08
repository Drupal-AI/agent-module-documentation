# Layout Builder Styles Conditions — manual setup guide

**Layout Builder Styles Conditions** (`lb_styles_conditions`) lets you attach
**Conditions API** rules to individual Layout Builder Styles, so a given style
option only appears in the Layout Builder interface when its conditions are met.
If you use the [Layout Builder Styles](https://www.drupal.org/project/layout_builder_styles)
module to offer editors a menu of visual styles (a "hero" treatment, a brand
color, a special section background), this module lets you decide *when* each of
those styles shows up in the dropdown.

For example, you can offer a "brand hero" style only on certain content types,
show a decorative section style only to specific editor roles, or expose a
campaign style only on certain paths. When an editor opens the block or section
style picker in Layout Builder, the module quietly evaluates each style's
conditions and removes the ones that don't apply — so editors simply never see
options that aren't relevant to what they're building.

It is important to understand what this does and does not do: it governs style
**availability in the authoring UI only**. It is a content-authoring
convenience that keeps the Styles dropdown tidy and enforces editorial
guidelines — it is **not** a security or access boundary on the rendered page.
Styles already saved onto a layout continue to render regardless of these
conditions.

This module builds on the [Conditions Helper](https://www.drupal.org/project/conditions_helper)
module (installed automatically as a dependency) for its condition-building
form and evaluator, and of course requires Layout Builder Styles itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

### Attach conditions to a style

1. Go to **Configuration → Content authoring → Layout Builder Styles**
   (`/admin/config/content/layout_builder_style`).
2. Add or edit a style (or style group).
3. In the **Condition restrictions** section, configure any available condition
   plugins — user role, content type, request path, and so on.
4. Save. The conditions are stored on the style itself (in its third-party
   settings), so they travel with a configuration export/import.

### What editors see

When an editor adds or configures a block or section in Layout Builder, the
module checks each relevant style's conditions and hides the whole style group
whose conditions fail. It respects Layout Builder Styles' own block/bundle and
layout restrictions and layers your conditions on top — so a style only appears
when *both* the base restrictions and your conditions allow it.

## Where it lives in the admin menu

There is one small site-wide settings form at
**Configuration → User interface → Layout Builder Styles Conditions**
(`/admin/config/user-interface/lb-styles-conditions`), gated by the
**`administer lb_styles_conditions`** permission (a restricted, trusted-admin
permission). Use it to build an **allow-list** of the condition plugins that
appear in the *Condition restrictions* section. Leave it empty to make all
available conditions selectable, or fill it in to limit editors to a chosen set.
