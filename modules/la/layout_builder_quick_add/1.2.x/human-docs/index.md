# Layout Builder Quick Add — manual setup guide

**Layout Builder Quick Add** (`layout_builder_quick_add`) speeds up adding blocks
in core **Layout Builder**. Core's add‑block flow is a sequence of off‑canvas
panels — open the sidebar, pick a category, pick a block, configure it — and on a
page assembled from many components that friction adds up. This module replaces the
first step: when you click **Add block**, instead of opening the sidebar it shows a
selection of block types right there so you can pick one directly. A **See more
blocks** link is always available to fall back to the standard Drupal core
workflow.

Beyond the direct picker, it can show or hide each block type's description in the
chooser and warn you when a block type has multiple view modes enabled. It ships
with styling for the default admin theme as well as **Claro** and **Gin** support.

The module integrates cleanly with Layout Builder's own access model: its
add and cancel routes carry Layout Builder's `_layout_builder_access: 'view'`
requirement and work on the same tempstore, so it inherits who is allowed to edit a
layout rather than inventing its own rules. It does add one permission of its own,
**Administer Layout Builder Quick Add configuration**, which is marked
*restrict access* and carries a security warning — deciding which blocks are offered
is close to deciding what can be placed, so grant it only to trusted roles. It
depends on core Layout Builder and targets Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the module's settings form, for tuning
   how the quick‑add chooser behaves.

## Where it lives in the admin menu

The module's own settings form sits at **Configuration → Content authoring →
Layout Builder Quick Add** (`/admin/config/content/layout_builder_quick_add`). The
quick‑add interface itself appears inside the Layout Builder editing UI once the
module is enabled — click **Add block** in any Layout Builder layout and the direct
picker replaces the off‑canvas sidebar.
