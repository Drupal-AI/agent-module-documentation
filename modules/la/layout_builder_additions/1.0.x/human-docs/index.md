# Layout Builder Additions — manual setup guide

**Layout Builder Additions** (`layout_builder_additions`) is a small
quality-of-life module for core **Layout Builder**. It makes three targeted
improvements to the editing experience, all applied automatically the moment you
enable it — there is nothing to configure.

What it changes:

- **Meaningful block-form titles.** When you add or edit an inline block in Layout
  Builder, the form heading normally reads a generic "Configure block". This
  module replaces it with a descriptive title such as *"Configure block:
  Accordion"*, using the block's admin label or its block-content type — much
  clearer on complex layouts with many block types.
- **Tidier block forms.** It hides the redundant "Administrative label" field on
  the add/configure block forms. For **media** inline blocks it also moves the
  label and the view-mode selector to the top of the form and relabels "View
  mode" as the friendlier "Image size".
- **A quick "Layout" link.** On content admin listings it adds a **Layout**
  operation link to nodes (for layout-enabled content types), so an editor can
  jump straight to a node's layout override. This link only appears for users who
  already have permission to edit that node's layout — it grants no new access.

That's the whole module: enable it and these tweaks apply; uninstall it and
everything reverts. It has no settings page, no permissions, and no config
entities. It pairs nicely with **Layout Builder Modal**, which adds a modal for
adding and configuring blocks.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no admin page — the module has no configuration. Its improvements simply
appear inside the Layout Builder editing UI (for layout-enabled displays under
**Structure**) and on the content admin listing at **Content**
(`/admin/content`).

## How to use it

There is nothing to set up beyond enabling the module. To benefit from it, use
Layout Builder as normal:

1. Enable Layout Builder on a content type's display (**Structure → Content types
   → *(type)* → Manage display → Layout options**), if you haven't already.
2. Edit a layout and add or configure an inline block — you'll see the new,
   descriptive "Configure block: …" heading and the tidied-up form.
3. Visit **Content** (`/admin/content`); nodes on layout-enabled types show a
   **Layout** action link (for users with the right permissions).

To revert every change, simply uninstall the module.
