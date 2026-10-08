# Layout Builder Blocks — manual setup guide

**Layout Builder Blocks** (`layout_builder_blocks`) adds a visual **Style** tab to
every block you add or edit inside Layout Builder. From that tab, content editors
can apply ready-made styles — background color, text color and alignment, padding,
margin, border, box-shadow, and scroll animation — to an individual block without
writing any CSS or deploying a theme change. It brings the same styling controls
that Bootstrap Styles already offers for Layout Builder *sections* down to the
level of individual *blocks*.

When you add or edit a block in a layout, the block form is reorganized into two
tabs: a **Content** tab with the block's normal fields, and a **Style** tab with
the styling controls. The styles an editor picks are saved onto that block within
the layout, and re-applied (as utility CSS classes and wrapper markup) whenever the
page is rendered. This lets content teams build styled landing pages entirely
through the UI.

This module builds directly on the **Bootstrap Styles** module (`bootstrap_styles`),
which is a required dependency and supplies the actual style definitions (the color
palette, spacing scale, and so on). It also needs core's **Layout Builder** to be
in use — that is a functional requirement rather than a formal dependency, since
the whole point is to enhance Layout Builder. It runs on Drupal 9.3, 10, or 11 and
ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — how styles are stored on a
section component, the render event subscriber, and the config keys — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Bootstrap Styles dependency) and enable the module.
2. [Configuration](configuration/index.md) — choose which style controls editors
   can use and, optionally, which blocks may be styled.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → Content authoring → Layout
Builder Blocks** (`/admin/config/layout-builder-blocks/styles`). The styling
itself happens inside Layout Builder — on the block add/edit dialog, in the new
**Style** tab — not on a standalone admin page. Access to the settings form uses
the **Configure bootstrap layout builder** permission that comes from the
Bootstrap Styles module.

## How to use it

Once enabled, open any Layout Builder layout, add or edit a block, and you'll see
the **Content** and **Style** tabs. Switch to **Style**, set a background color or
some spacing, and save — the block renders with those styles. The
[Configuration](configuration/index.md) page covers the site-wide choices: which
style controls appear, and whether to limit styling to certain blocks. Note that
the Style tab is deliberately hidden on Dashboard layouts.
