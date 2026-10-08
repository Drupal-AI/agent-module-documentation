<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Direct Add — manual setup guide

**Layout Builder Direct Add** (`lb_direct_add`) speeds up page building in Layout
Builder. Normally, adding a block means clicking **Add block**, waiting for the
"Choose a block" tray to slide out, then picking a block type — a two-step dance for
every block. This module replaces that single link with a **drop-button** (or a
labelled **popover menu**) that lists the available custom/inline block types
directly, so an editor can add the block they want in one click.

The list is context-aware. In each region it shows the inline block types that are
actually allowed there, and if you also run
[Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions),
it respects those rules so only permitted block types appear. A **"More…"** link back
to the full off-canvas chooser is still available — but only for users you grant a
specific permission, so you can limit junior editors to a pre-approved set of inline
block types.

There is a small settings form with just one real choice: whether the widget is a
**dropbutton** or a **popover menu** (and, for the popover, what its trigger label
says). Once enabled, the widget applies automatically to every Layout Builder region,
in both default layouts and per-entity overrides — there is no per-display switch to
flip.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the dropbutton-vs-popover setting and
   the two permissions, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Layout Builder Direct
Add** (`/admin/config/content/layout-builder-direct-add`). The widget itself appears
inside the Layout Builder editing interface for any entity that uses Layout Builder.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The direct-add
   widget is active in Layout Builder straight away, using the default dropbutton
   style.
2. Optionally open the settings form to switch to a popover menu or rename its
   trigger — see [Configuration](configuration/index.md).
3. Grant the *access layout builder direct add more options* permission to the roles
   that should keep the full "More…" block chooser; withhold it from roles you want
   limited to the direct list.
4. Edit any Layout Builder layout — instead of the old **Add block** link, each
   region now offers the block types directly.
