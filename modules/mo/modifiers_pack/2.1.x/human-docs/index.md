# Modifiers Pack — manual setup guide

**Modifiers Pack** (`modifiers_pack`) is a starter collection of ready-made
modifier plugins for the [Modifiers](https://www.drupal.org/project/modifiers)
framework. Where the base Modifiers module defines *how* configurable visual
styling is applied to components without writing CSS, Modifiers Pack gives you the
actual, practical styling controls to hand editors on day one.

The pack ships a broad set of modifiers, each as its own submodule so you enable
only the ones you want:

- Absolute Height, Relative Height, HTML Font Size
- Colors, Custom Colors, Fonts
- Corners, Padding, Shadow
- Image Background, Video Background, Parallax Background, Image FX
- Linear Gradient, Radial Gradient, Custom Linear Gradient, Custom Radial Gradient
- Hide

It depends on the base **`modifiers`** module and runs on Drupal 10.1, 11, and 12.
Each individual modifier submodule may carry its own requirements, so check a
submodule's README/info file if it has extra needs. Like the framework it builds
on, Modifiers Pack is purely a theming/presentation layer — the modifiers emit
styles and markup for visual effect and play no access-control role. It is
maintained by Morpht.

There is no central settings form: you expose options by enabling the submodule
plugins you want and then configuring them through the UI on Modifiers-enabled
components. This guide folds that setup into this page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the pack with Composer and
   enable the modifier submodules you need.

There is **no configuration page** for this module. You enable the specific
modifier plugins you want and configure them per component, as described in "How
to use it" below.

## Where it lives in the admin menu

Modifiers Pack adds no central settings page. You choose which modifier plugins
are available under **Extend** (`/admin/modules`), by enabling the individual
submodules, and then configure them where the modifiers field lives on your
content, blocks, or paragraphs.

## How to use it

1. Make sure the base **Modifiers** framework is installed and enabled (see
   [Installation](installation/index.md)).
2. Under **Extend** (`/admin/modules`), enable only the modifier submodules whose
   options you want to expose to editors — for example Colors, Padding, Shadow, or
   Image Background. Enabling fewer keeps the editor's palette focused.
3. Attach a modifiers field to the entity, block, or paragraph type you want to be
   able to style (this is done through the base Modifiers framework).
4. As an editor, pick the modifier(s) on your content and set their options
   (colors, spacing, background media, and so on). The styling is applied at
   render time.

> **Tip:** Because each modifier is a separate submodule, treat the enabled set as
> a curated design vocabulary — enable what your design system needs and leave the
> rest off rather than turning on everything.
