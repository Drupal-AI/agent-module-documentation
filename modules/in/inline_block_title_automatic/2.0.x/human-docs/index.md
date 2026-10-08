# Inline Block Title Automatic — manual setup guide

**Inline Block Title Automatic** (`inline_block_title_automatic`) removes a confusing
step from the Layout Builder authoring experience. When an editor adds or configures a
content block (`block_content` — either a reusable library block or an inline block) in
Layout Builder, core shows a required **placement label ("Title")** field and a
**Display title** checkbox. These duplicate the block's own "Block description"/`info`
field and routinely puzzle editors: is this the heading readers will see, or just an
internal name? This module takes the decision away — for content blocks it hides both
controls, so authors are never asked for a placement title at all.

The effect is that a block's description stays purely administrative, and any
user-facing heading has to come from a real field on the block. Behind the scenes the
module forces the placement label to a fixed value ("Inline block") and forces the
"Display title" setting off, so no internal label ever leaks onto the front end. It
only touches `block_content` blocks — system blocks, views blocks, and the like are
left exactly as core renders them.

This is a **zero-configuration** module: enabling it (alongside Layout Builder) is the
entire setup. There is **no settings form, config, permission, Drush command, or
plugin**. It requires **PHP 8.1+** and core's **Layout Builder** module, and applies
its behaviour everywhere Layout Builder places a content block.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent — the exact forms it alters and how to
verify it — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That's the whole setup.

## Where it lives in the admin menu

Nowhere — the module has no admin pages, no settings, and no permissions. Its effect
shows up inside **Layout Builder** itself: when you add or configure a content block on
a Layout-Builder-enabled display, the "Title" and "Display title" controls are simply
gone.

## How to use it

There is nothing to configure. Once the module is enabled on a site that uses Layout
Builder:

1. **Enable Layout Builder on a display.** For a content type that uses Layout Builder
   (under **Structure → Content types → (type) → Manage display**), edit a node's
   layout.
2. **Add a content block.** Choose **Add block** and pick a reusable library block or
   create an inline block.
3. **Notice the simplified form.** The **placement label ("Title")** field and the
   **Display title** checkbox are no longer shown. The block's own description stays
   internal, and any visible heading must come from a field on the block itself.

The behaviour applies automatically to every content block placed through Layout
Builder — there are no per-block or per-display options to set. For the precise forms
it hooks and how to confirm it's active, see the [`agent/`](../agent/start.md) docs.
