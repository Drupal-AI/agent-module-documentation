<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Editing Helper

## Default help text
Go to **Configuration → Content authoring → Description Helper** (`/admin/config/content/editing_helper/config`, requires `administer editing helper permissions`). Set:
- **Block Title** — heading for the help panel.
- **Block Inline Text** / **Block Reusable Text** — defaults for inline vs reusable block content.
- **View Field Text**, **View Node Text**, **View Taxonomy Term Text** — defaults for field/views contexts.

These persist in `editing_helper.help_config`.

## Per-field help
Editing any field's configuration form shows an **Editing Helper Description** textarea; its value is stored as the field's `editing_helper` third-party setting and takes precedence over the generic field default.

## Per-view help
Enable the **Editing Helper** display extender on a view to attach a `view_description_helper` description to a display; it overrides the node/taxonomy defaults.

## Rendering & access
`hook_preprocess_block()` chooses the most specific help text for a block (block_content → reusable/inline, field_block → per-field or default, views_block → view/extender or node/taxonomy default) and adds a toggle button + `help_content` panel **only** for users with `access to editing helper`. Grant that permission to editor roles; keep `administer editing helper permissions` to admins.

## Security note
Help text is authored by administrators (config form / field settings / view settings) and may contain HTML, so it is a trusted-role surface; there is no anonymous or mutating endpoint.
